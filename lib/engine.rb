require 'cartoset'
require 'rails'
require 'warden'
require 'rails_warden'

require 'cartoset/auth/omniauth_cartodb_authentication'
require 'cartoset/auth/warden_strategies'


module Cartoset
  class Engine < Rails::Engine

    initializer "cartoset.add_middleware" do

      config.app_middleware.use RailsWarden::Manager do |manager|
        manager.default_strategies :cartodb_oauth
        manager.failure_app = SessionsController if defined?(SessionsController)
      end

      host = oauth_key = oauth_secret = nil
      if CartoDB.const_defined?('Settings')
        host = CartoDB::Settings['host']
        oauth_key = CartoDB::Settings['oauth_key']
        oauth_secret = CartoDB::Settings['oauth_secret']
      end
      config.app_middleware.use OmniAuth::Strategies::Cartodb, host, oauth_key, oauth_secret

    end

  end
end

