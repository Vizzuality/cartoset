Cartoset::Application.routes.draw do
  resources :features

  root :to => "home#index"
end
