class Cartoset::Config

  @@path = Rails.root.join('config', 'cartoset_config.yml')

  cattr_accessor :path

  class << self

    def update(values)
      values.each do |key, value|
        settings[key.to_s] = value
      end
      consolidate_settings
    end

    def empty
      settings = {}
      consolidate_settings
    end

    def valid?
      settings.present? && settings['cartodb_oauth_key'].present? && settings['cartodb_oauth_secret'].present? && settings['app_name'].present? && settings['features_table'].present?
    end

    def [](key)
      settings[key]
    end

    def []=(key, value)
      settings[key] = value
    end

    def settings=(values)
      @@settings = values
    end
    private :settings=

    def settings
      @@settings ||= begin
        YAML.load_file(path) || {}
      rescue Exception => e
        {}
      end
    end
    private :settings

    def consolidate_settings
      File.open(path, "w") do |f|
        f.write(settings.to_yaml)
      end
    end
    private :consolidate_settings
  end
end