raw_config = YAML.load_file("#{Rails.root}/config/cartodb_config.yml")[Rails.env]
CARTODB = raw_config.to_options! unless raw_config.nil?
