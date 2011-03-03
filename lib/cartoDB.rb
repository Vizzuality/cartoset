require 'typhoeus'

module CartoDB

  class Client
    include Typhoeus

    def initialize(settings = nil)

      raise Exception.new 'CartoDB settings not found' if settings.nil?
      @cartodb_host = settings[:host]
      @cartodb_key  = settings[:api_key]
      @hydra        = Typhoeus::Hydra.new

    end

    def create_table(table_name = nil, schema = nil)

      cartodb_request 'tables', :post, :name => table_name do |response|
        created_table = Utils.parse_json(response)
        table_id      = created_table['id'] if created_table

        if table_id
          if schema.present?
            schema.each do |column|
              cartodb_request "tables/#{table_id}/update_schema", :put, { :what    => "add", :column  => column }
            end
          end
        end

        return created_table
      end.handled_response

    end

    def tables

      cartodb_request 'tables' do |response|
        return Utils.parse_json(response)
      end.handled_response

    end

    def table(table_id)

      cartodb_request "tables/#{table_id}" do |response|
        return Utils.parse_json(response)
      end.handled_response

    end

    def drop_table(table_id)

      cartodb_request "tables/#{table_id}", :delete do |response|
        Utils.parse_json(response)
      end.handled_response

    end

##################
# private methods

    def cartodb_request(uri, method = :get, params = {}, &block)
      if method.is_a? Hash
        params = method
        method = :get
      end

      params[:api_key] = @cartodb_key

      format = 'json'
      url    = "http://#{@cartodb_host}/api/json/#{uri}.#{format}"

      request = Request.new(url,
        :method => method,
        :params => params
      )

      request.on_complete do |response|

        if response.success?
          yield(response) if block_given?
        else
          raise CartoDBError.new url, method, response
        end
      end

      enqueue request
      execute_queue

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

  class CartoDBError < Exception

    UNDEFINED_ERROR_MESSAGE = 'CartoDB undefined error'

    def initialize(uri, method, http_response)
      @uri            = uri
      @method         = method
      @error_messages = [UNDEFINED_ERROR_MESSAGE]
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