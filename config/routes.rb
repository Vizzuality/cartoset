Cartoset::Application.routes.draw do

  resources :features

  namespace :admin do
    resources :dashboard
    resources :features
    resources :pages
    resources :settings
  end
  match '/admin' => 'admin/dashboard#index', :as => :admin

  match '/setup(/steps/:step_id)'    => 'setup#step', :as => :setup
  match '/setup/features_table_data' => 'setup#features_table_data'
  match '/setup/create_features_table' => 'setup#create_features_table', :as => :create_table

  match "/auth/cartodb", :as => :authorize
  match "/auth/:provider/callback" => "sessions#create"

  get '/login' => 'sessions#create', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout

  resources :features
  root :to => "home#index"
end
