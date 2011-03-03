require 'spec_helper'
require 'cartoDB'

describe CartoDB do

  before(:all) do
    raw_config = YAML.load_file("#{Rails.root}/config/cartodb_config.yml")[Rails.env]
    cartodb_settings = raw_config.to_options! unless raw_config.nil?

    @cartodb = CartoDB::Client.new cartodb_settings
  end

  before(:each) do
    drop_all_cartodb_tables @cartodb
  end

  after(:all) do
    drop_all_cartodb_tables @cartodb
  end

  it "should create a table and get its table definition" do
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

  it "should return user's table list" do
    table_1 = @cartodb.create_table 'table #1'
    table_2 = @cartodb.create_table 'table #2'

    tables_list = @cartodb.tables
    tables_list.should have(2).items
    tables_list.first['id'].should == table_1['id']
    tables_list.last['id'].should == table_2['id']

  end

  it "should drop a table" do
    table_1 = @cartodb.create_table 'table #1'
    table_2 = @cartodb.create_table 'table #2'
    table_3 = @cartodb.create_table 'table #3'

    @cartodb.drop_table table_2['id']

    tables_list = @cartodb.tables
    tables_list.should have(2).items
    tables_list.first['id'].should == table_1['id']
    tables_list.last['id'].should == table_3['id']
  end

end
