require 'test_helper'

class SimpleDummyController < ApplicationController
  def index
    render plain: root_path
  end
end

class WithRoutingDummyController < ApplicationController
  def index
    render plain: root_path
  end

  def default_url_options
    {defaults: true}
  end
end

class SimpleControllerTest < ActionController::TestCase
  tests SimpleDummyController

  test "passes" do
    with_routing do |set|
      set.draw do
        get ':action' => 'simple_dummy'
      end

      get :index
      assert_response :success
    end
  end
end

class WithDefaultsControllerTest < ActionController::TestCase
  tests WithRoutingDummyController

  test "fails" do
    with_routing do |set|
      set.draw do
        get ':action' => 'with_routing_dummy'
      end

      get :index
      assert_response :success
    end
  end
end
