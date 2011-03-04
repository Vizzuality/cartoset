require 'typhoeus'

module CartoDB

  class Client
    include Typhoeus

    def initialize(settings = nil)
      raise Exception.new 'CartoDB settings not found' if settings.nil?
      @cartodb_host = settings[:host]
      @cartodb_key  = settings[:api_key]
      @hydra        = Typhoeus::Hydra.new(:max_concurrency => 200)
    end

    def create_table(table_name = nil, schema = nil)
      request = cartodb_request 'tables', :post, :params => {:name => table_name} do |response|
        created_table = Utils.parse_json(response)
        table_id      = created_table['id'] if created_table

        if table_id
          if schema.present?
            schema.each do |column|
              cartodb_request "tables/#{table_id}/update_schema", :put, :params => { :what => "add", :column  => column }
            end
            execute_queue
          end
        end


        return created_table
      end

      execute_queue

      request.handled_response
    end

    def add_column(table_id, column_name, column_type)
      cartodb_request "tables/#{table_id}/update_schema",
                      :put,
                      :params => {
                        :what => "add",
                        :column  => {
                          :name => column_name,
                          :type => column_type
                        }
                      },
                      :headers => {'Content-Length' => '0'}

      execute_queue
    end

    def drop_column(table_id, column_name)
      cartodb_request "tables/#{table_id}/update_schema",
                      :put,
                      :params => {
                        :what => "drop",
                        :column  => {
                          :name => column_name
                        }
                      },
                      :headers => {'Content-Length' => '0'}

      execute_queue
    end

    def change_column(table_id, old_column_name, new_column_name, column_type)
      cartodb_request "tables/#{table_id}/update_schema",
                      :put,
                      :params => {
                        :what => "modify",
                        :column  => {
                          :old_name => old_column_name,
                          :new_name => new_column_name,
                          :type => column_type
                        }
                      },
                      :headers => {'Content-Length' => '0'}

      execute_queue
    end

    def tables
      request = cartodb_request 'tables' do |response|
        return Utils.parse_json(response)
      end

      execute_queue

      request.handled_response
    end

    def table(table_id)
      request = cartodb_request "tables/#{table_id}" do |response|
        return Utils.parse_json(response)
      end

      execute_queue

      request.handled_response
    end

    def drop_table(table_id)
      cartodb_request "tables/#{table_id}", :delete

      execute_queue
    end

    def insert_row(table_id, row)
      cartodb_request "tables/#{table_id}/rows", :post, :params => row

      execute_queue
    end

    def update_row(table_id, row_id, row)
      cartodb_request "tables/#{table_id}/rows/#{row_id}", :put, :params => row

      execute_queue
    end

    def delete_row(table_id, row_id)
      cartodb_request "tables/#{table_id}/rows/#{row_id}", :delete

      execute_queue
    end

    def query(query)
      request = cartodb_request "tables/query", :params => {:query => query} do |response|
        return Utils.parse_json(response)
      end

      execute_queue

      request.handled_response
    end

##################
# private methods

    def cartodb_request(uri, method = :get, arguments = {:params => {}}, &block)
      params = arguments[:params]
      if method.is_a? Hash
        params = method[:params]
        method = :get
      end

      params[:api_key] = @cartodb_key

      format = 'json'
      url    = "http://#{@cartodb_host}/api/json/#{uri}"
      headers =  {'Accept' => Mime::JSON}
      headers = headers.merge(arguments[:headers]) if arguments[:headers]

      request = Request.new(url,
        :method        => method,
        :params        => params,
        :headers       => headers,
        :verbose       => false
      )

      request.on_complete do |response|
        if response.success?
          yield(response) if block_given?
        else
          puts response.code
          puts response.body
          raise CartoError.new url, method, response
        end
      end

      enqueue request
      request
    end
    private :cartodb_request

    def enqueue(request)
      @hydra.queue request
    end
    private :enqueue

    def execute_queue
      @hydra.run
    end
    private :execute_queue

  end

  class CartoError < Exception

    def initialize(uri, method, http_response)
      @uri            = uri
      @method         = method
      @error_messages = ['undefined CartoDB error']
      @status_code    = 400

      if http_response
        @status_code = http_response.code
        json = Utils.parse_json(http_response)
        @error_messages = json['errors'] if json
      end

    end

    def to_s
      <<-EOF
        There were errors running the #{@method.upcase} request "#{@uri}":
        #{@error_messages.map{|e| "- #{e}"}.join("\n")}
      EOF
    end
  end

  module Utils

    def self.parse_json(response)
      json = nil
      unless response.nil? || response.body.blank?
        begin
          json = JSON.parse(response.body)
        rescue JSON::ParserError => e
        end
      end
      json
    end

  end

end