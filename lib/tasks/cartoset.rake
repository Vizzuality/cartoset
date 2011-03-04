
namespace :cartoset do
  desc "Creates the cartodb schema"
  task :create_schema => :environment do
    errors = []

    puts ''
    puts 'Creating table features...'

    begin
      CARTODB.create_table 'features'
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
      table = CARTODB.table 'features'
      CARTODB.drop_table table.id

      puts '... done!'
    rescue CartoDB::CartoError => e
      errors << e
    end

    print_errors(errors)
  end

  desc "Creates random test data"
  task :test_data => :environment do
    features_table = CARTODB.table 'features'

    25.times do
      CARTODB.insert_row features_table.id, {
        'name'        => String.random(30),
        'description' => String.random(200),
        'latitude'    => Float.random_latitude,
        'longitude'   => Float.random_longitude
      }
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