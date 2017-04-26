require 'test_helper'

class WithDefaultsControllerTest < ActionController::TestCase
  test "passes for predefined routes" do
    TracePoint.trace(:call) do |tp|
      p tp.class
      get :index
      assert_response :success
    end
  end

  test "fails for test routes" do
    with_routing do |set|
      set.draw do
        get 'with_defaults2' => 'with_defaults#index'
      end

      get :index
      assert_response :success
    end
  end
end
