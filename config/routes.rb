Rails.application.routes.draw do
  root to: "welcome#index"
  get "with_defaults" => "with_defaults#index"
end
