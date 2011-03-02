require 'spec_helper'
require 'cartoDB'

describe CartoDB do

  before(:all) do
    raw_config = YAML.load_file("#{Rails.root}/config/cartodb_config.yml")[Rails.env]
    cartodb_settings = raw_config.to_options! unless raw_config.nil?

    @cartodb = CartoDB::Client.new cartodb_settings
    @cartodb.drop_tables
  end

  after(:all) do
    @cartodb.drop_tables
  end

  it "should create a table" do
    table = @cartodb.create_table 'cartodb_spec', [
                                    {:name => 'field1', :type => 'text'},
                                    {:name => 'field2', :type => 'number'},
                                    {:name => 'field3', :type => 'date'},
                                    {:name => 'field4', :type => 'boolean'}
                                  ]
    table.should_not be_nil
    table['id'].should be > 0
    table = @cartodb.table table['id']
    table['columns'].should have(11).items
    table['columns'].should include(["cartodb_id", "number"])
    table['columns'].should include(["name", "string"])
    table['columns'].should include(["latitude", "number", "latitude"])
    table['columns'].should include(["longitude", "number", "longitude"])
    table['columns'].should include(["description", "string"])
    table['columns'].should include(["created_at", "date"])
    table['columns'].should include(["updated_at", "date"])
    table['columns'].should include(["field1", "string"])
    table['columns'].should include(["field2", "number"])
    table['columns'].should include(["field3", "date"])
    table['columns'].should include(["field4", "boolean"])
  end
end
