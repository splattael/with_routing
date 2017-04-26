class WithDefaultsController < ApplicationController
  def index
    render plain: root_path
  end

  def default_url_options
    {with_defaults: true}
  end
end
