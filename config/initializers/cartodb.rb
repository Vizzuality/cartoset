require 'cartodb'

raw_config = YAML.load_file("#{Rails.root}/config/cartodb_config.yml")[Rails.env]
cartodb_settings = raw_config.to_options! unless raw_config.nil?

CARTODB = CartoDB::Client.new cartodb_settings
