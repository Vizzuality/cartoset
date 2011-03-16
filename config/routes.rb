Cartoset::Application.routes.draw do

  resources :features

  namespace :admin do
    resources :dashboard
    resources :features
    resources :pages
    resources :settings
  end

  match '/admin' => 'admin/dashboard#index'

  match '/register' => 'register#step0'
  match '/register/step1' => 'register#step1'
  match '/register/step2' => 'register#step2'
  match '/register/step3' => 'register#step3'
  match '/register/step4' => 'register#step4'

  root :to => "home#index"
  match "/auth/:provider/callback" => "sessions#create"

  get '/logout' => 'sessions#destroy', :as => :logout

  resources :features
end
