require 'cartoset'
require 'rails'

module Cartoset
  class Engine < Rails::Engine

    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

  end
end

