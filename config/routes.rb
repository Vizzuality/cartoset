Cartoset::Application.routes.draw do
  resources :features

  namespace :admin do
    resources :dashboard
  end
  match '/admin' => 'admin/dashboard#index'

  root :to => "home#index"
  match "/auth/:provider/callback" => "sessions#create"

  get '/logout' => 'sessions#destroy', :as => :logout

  resources :features
end
