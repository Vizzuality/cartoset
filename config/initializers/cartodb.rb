require 'cartodb-rb-client/carto_db'

cartodb_settings = YAML.load_file("#{Rails.root}/config/cartodb_config.yml")[Rails.env.to_s]

CARTODB = CartoDB::Client.new cartodb_settings
