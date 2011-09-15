Rails.application.routes.draw do

  resources :features

  namespace :admin do
    resources :dashboard
    resources :features
    resources :pages
    resources :settings
  end
  match '/admin' => 'admin/dashboard#index', :as => :admin

  match '/setup(/steps/:step_id)'    => 'setup#step', :as => :setup
  match '/setup/cartodb' => 'setup#cartodb', :as => :setup_cartodb
  match '/setup/features_table_data' => 'setup#features_table_data'
  match '/setup/create_features_table' => 'setup#create_features_table', :as => :create_table

  match "/auth/cartodb", :as => :cartodb_authorize
  match "/auth/:provider/callback" => "sessions#create"

  get '/login' => 'sessions#create', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout
  get '/login_required' => 'sessions#new', :as => :login_required

  match ':controller(/:action(/:id))'

  resources :features
  root :to => "home#index"
end
