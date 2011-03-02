Cartoset::Application.routes.draw do
  resources :features

  root :to => "home#index"
  match "/auth/:provider/callback" => "sessions#create"

  resources :features
end
