require 'test_helper'

class WithDefaultsControllerTest < ActionController::TestCase
  test "passes for predefined routes" do
    get :index
    assert_response :success
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
