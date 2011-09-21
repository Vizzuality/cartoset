require 'cartoset/version'
require 'cartodb-rb-client'

if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'engine'
  require 'application_controller'
end


