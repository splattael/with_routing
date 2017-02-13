require 'test_helper'

class ApplicationDummyController < ApplicationController
  def foo
    link = root_path
    render :text => link
  end
end

class ApplicationControllerTest < ActionController::TestCase
  tests ApplicationDummyController

  test "false" do
    with_routing do |set|
      set.draw do
        match ':action' => 'application_dummy', :via => :all
      end

      get :foo
      # boom
    end
  end
end
