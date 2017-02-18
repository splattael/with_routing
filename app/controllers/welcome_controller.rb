class WelcomeController < ApplicationController
  def index
    render plain: "welcome"
  end
end
