require 'test_helper'
require 'pp'

class WithDefaultsControllerTest < ActionController::TestCase
  test "passes for predefined routes" do
    trace do
      get :index
      assert_response :success
    end
  end

  # test "fails for test routes" do
  #   with_routing do |set|
  #     set.draw do
  #       get 'with_defaults2' => 'with_defaults#index'
  #     end
  #
  #     trace do
  #       get :index
  #       assert_response :success
  #     end
  #   end
  # end

  private

  def printme(tp, ident, prefix = "")
    path = tp.path.gsub(/.*?gems\//, '')
    path = path.gsub(Rails.root.to_s, '')
    path = path.gsub("/home/peter/devel/rails/", '')
    puts "%s%s%s#%s\t%s:%s" % ["  " * ident, prefix, tp.self.class, tp.method_id, path, tp.lineno]
  end

  def printparams(tp, ident)
    method = tp.self.method(tp.method_id)
    method.parameters.each do |p|
      puts "%s - %s: %s" % ["  " * ident, p.last, obfusce(tp.binding.local_variable_get(p.last).pretty_inspect)]
    end
  rescue
    # raise
    nil
  end

  def obfusce(x)
    x.gsub(/0x[a-z0-9]{14}/, "0xXXXXXXXXXXXXX")
  end

  def trace
    $ident = 0
    tracers = []
    tracers << TracePoint.new(:call) { |tp|
      printme(tp, $ident)
      printparams(tp, $ident)
      $ident += 1
    }

    tracers << TracePoint.new(:return) { |tp|
      printme(tp, $ident)
      $ident -= 1
    }

    tracers << TracePoint.new(:raise) { |tp|
      printme(tp, $ident, "RAISE")
    }

    tracers.each(&:enable)

    yield
  ensure
    tracers.each(&:disable)
  end
end
