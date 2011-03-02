namespace :cartoset do
  desc "Creates the cartodb schema"
  task :create_schema => :environment do
    errors = []

    puts ''
    puts '##############################################'
    puts 'Creating table features...'

    hydra = Typhoeus::Hydra.new

    create_table_request = Typhoeus::Request.new("http://#{CARTODB[:host]}/api/json/tables.json",
                                                 :method => :post,
                                                 :params => {
                                                   :api_key => CARTODB[:api_key],
                                                   :name => 'features'
                                                 })

    create_table_request.on_complete do |response|

      if response.success?
        puts '... done!'
      else
        errors += parse_errors(response)
      end
    end

    hydra.queue create_table_request
    hydra.run

    print_errors(errors)
  end

  desc "Drops the cartodb schema"
  task :drop_schema => :environment do
    errors = []

    puts ''
    puts '##############################################'
    puts 'Droping table features...'

    hydra = Typhoeus::Hydra.new

    list_tables_request = Typhoeus::Request.new("http://#{CARTODB[:host]}/api/json/tables.json",
                                                :method => :get,
                                                :params => {
                                                  :api_key => CARTODB[:api_key]
                                                })

    list_tables_request.on_complete do |response|
      if response.success?
        tables_list = JSON.parse(response.body)
        table_data = tables_list.select{|t| t['name'].downcase.match(/features/)}.first

        if table_data && table_data['id']
          table_id = table_data['id']

          delete_table_request = Typhoeus::Request.new("http://#{CARTODB[:host]}/api/json/tables/#{table_id}.json",
                                                      :method => :delete,
                                                      :params => {
                                                        :api_key => CARTODB[:api_key]
                                                      })
          delete_table_request.on_complete do |response|
            if response.success?
              puts '... done!'
            else
              errors += parse_errors(response)
            end
          end

          hydra.queue delete_table_request
          hydra.run

        else
          errors << 'Table features does not exist'
        end
      else
        errors += parse_errors(response)
      end
    end

    hydra.queue list_tables_request
    hydra.run

    print_errors(errors)
  end

  def parse_errors(response)
    json_response = JSON.parse(response.body)
    return json_response['errors'] if json_response && json_response['errors']
  end

  def print_errors(errors)
    unless errors.empty?
      puts ''
      puts 'Errors creating table features:'
      errors.each do |error|
        puts "- #{error}"
      end
      puts '##############################################'
    end
  end
end