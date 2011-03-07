Cartoset::Application.routes.draw do
  resources :features

  root :to => "home#index"
  match "/auth/:provider/callback" => "sessions#create"

  get '/logout' => 'sessions#destroy', :as => :logout

  resources :features
end
