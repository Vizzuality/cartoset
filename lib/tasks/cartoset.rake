
namespace :cartoset do
  desc "Creates the cartodb schema"
  task :create_schema => :environment do
    errors = []

    puts ''
    puts 'Creating table features...'

    begin
      CartoDB::Connection.create_table 'features'
      puts '... done!'
    rescue CartoDB::CartoError => e
      errors << e
    end

    print_errors(errors)
  end

  desc "Drops the cartodb schema"
  task :drop_schema => :environment do
    errors = []

    puts ''
    puts 'Droping table features...'

    begin
      table = CartoDB::Connection.table 'features'
      CartoDB::Connection.drop_table table.id

      puts '... done!'
    rescue CartoDB::CartoError => e
      errors << e
    end

    print_errors(errors)
  end

  desc "Creates random test data"
  task :test_data => :environment do
    CartoDB::Connection.table 'features'

    25.times do
      CartoDB::Connection.insert_row 'features', {
        'name'        => String.random(30),
        'description' => String.random(200),
        'latitude'    => Float.random_latitude,
        'longitude'   => Float.random_longitude
      }
    end
  end

  namespace :heroku do
    task :config => :environment do
      puts "Reading config/cartoset_config.yml and sending config vars to Heroku..."

      [:staging, :production].each do |env|
        system Cartoset::Config.settings.inject('heroku config:add'){|command, key_value| command << " #{key_value[0]}=#{key_value[1]}"} << " --remote #{env}"
      end
    end
  end

  def print_errors(errors)
    unless errors.empty?
      puts ''
      puts 'Errors creating table features:'
      errors.each do |error|
        puts "- #{error}"
      end
    end
  end
end
