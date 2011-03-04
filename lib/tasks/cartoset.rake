
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
      table = CARTODB.tables.select{|table| table['name'].eql?('features')}.first
      CARTODB.drop_table table['id']

      puts '... done!'
    rescue CartoDB::CartoError => e
      errors << e
    end

    print_errors(errors)
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