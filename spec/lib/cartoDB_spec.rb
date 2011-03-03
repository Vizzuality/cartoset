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

  it "should add and remove colums in a previously created table" do
    table = @cartodb.create_table 'cartodb_spec'
    @cartodb.add_column table['id'], :name => 'field1', :type => 'text'
    @cartodb.add_column table['id'], :name => 'field2', :type => 'number'
    @cartodb.add_column table['id'], :name => 'field3', :type => 'date'

    table = @cartodb.table table['id']
    table['columns'].should have(10).items
    table['columns'].should include(["field1", "string"])
    table['columns'].should include(["field2", "number"])
    table['columns'].should include(["field3", "date"])

    @cartodb.drop_column table['id'], :name => 'field3'
    table = @cartodb.table table['id']
    table['columns'].should have(9).items
    table['columns'].should_not include(["field3", "date"])
  end

  it "should change a previously created column" do
    table = @cartodb.create_table 'cartodb_spec', [{:name => 'field1', :type => 'text'}]
    @cartodb.change_column table['id'], {
      :old_name => "field1",
      :new_name => "changed_field",
      :type     => "number"
    }
    table = @cartodb.table table['id']
    table['columns'].should_not include(["field1", "string"])
    table['columns'].should include(["changed_field", "number"])
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

  it "should insert a row in a table" do
    table = @cartodb.create_table 'table #1', [
                                    {:name => 'field1', :type => 'text'},
                                    {:name => 'field2', :type => 'number'},
                                    {:name => 'field3', :type => 'date'},
                                    {:name => 'field4', :type => 'boolean'}
                                  ]

    today = Time.now

    @cartodb.insert_row table['id'], {
      'name'        => 'cartoset',
      'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'latitude'    => 40.423012,
      'longitude'   => -3.699732,
      'field1'      => 'lorem',
      'field2'      => 100.99,
      'field3'      => today,
      'field4'      => true
    }

    table = @cartodb.table table['id']
    table['total_rows'].should == 1
    table['rows'].should have(1).item
    table['rows'].first['cartodb_id'].should == 1
    table['rows'].first['name'].should == 'cartoset'
    table['rows'].first['latitude'].should == 40.423012
    table['rows'].first['longitude'].should == -3.699732
    table['rows'].first['description'].should == 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    table['rows'].first['field1'].should == 'lorem'
    table['rows'].first['field2'].should == 100.99
    table['rows'].first['field3'].should == today.strftime("%Y-%m-%d %H:%M:%S")
    table['rows'].first['field4'].should == true
  end

  it "should update a row in a table" do
    table = @cartodb.create_table 'table #1', [
                                    {:name => 'field1', :type => 'text'},
                                    {:name => 'field2', :type => 'number'},
                                    {:name => 'field3', :type => 'date'},
                                    {:name => 'field4', :type => 'boolean'}
                                  ]

    today = Time.now

    @cartodb.insert_row table['id'], {
      'name'        => 'cartoset',
      'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'latitude'    => 40.423012,
      'longitude'   => -3.699732,
      'field1'      => 'lorem',
      'field2'      => 100.99,
      'field3'      => today,
      'field4'      => true
    }

    table = @cartodb.table table['id']

    row_id = table['rows'].first['cartodb_id']

    @cartodb.update_row table['id'], row_id, {
      'name'        => 'updated_row',
      'description' => 'Eu capto illum, iustum, brevitas, lobortis torqueo importunus, capio sudo. Genitus importunus amet iaceo, abluo obruo consequat, virtus eros, aliquip iustum nisl duis zelus. Ymo augue nobis exerci letatio sed.',
      'latitude'    => 40.415113,
      'longitude'   => -3.699871,
      'field1'      => 'illum',
      'field2'      => -83.24,
      'field3'      => today + 1.day,
      'field4'      => false
    }

    table = @cartodb.table table['id']
    table['total_rows'].should == 1
    table['rows'].should have(1).item
    table['rows'].first['cartodb_id'].should == 1
    table['rows'].first['name'].should == 'updated_row'
    table['rows'].first['latitude'].should == 40.415113
    table['rows'].first['longitude'].should == -3.699871
    table['rows'].first['description'].should == 'Eu capto illum, iustum, brevitas, lobortis torqueo importunus, capio sudo. Genitus importunus amet iaceo, abluo obruo consequat, virtus eros, aliquip iustum nisl duis zelus. Ymo augue nobis exerci letatio sed.'
    table['rows'].first['field1'].should == 'illum'
    table['rows'].first['field2'].should == -83.24
    table['rows'].first['field3'].should == (today + 1.day).strftime("%Y-%m-%d %H:%M:%S")
    table['rows'].first['field4'].should == false
  end

  it "should delete a table's row" do
    table = @cartodb.create_table 'table #1', [
                                    {:name => 'field1', :type => 'text'},
                                    {:name => 'field2', :type => 'number'},
                                    {:name => 'field3', :type => 'date'},
                                    {:name => 'field4', :type => 'boolean'}
                                  ]

    today = Time.now

    @cartodb.insert_row table['id'], {
      'name'        => 'cartoset',
      'description' => 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'latitude'    => 40.423012,
      'longitude'   => -3.699732,
      'field1'      => 'lorem',
      'field2'      => 100.99,
      'field3'      => today,
      'field4'      => true
    }
    row_id = 1

    @cartodb.delete_row table['id'], row_id

    table = @cartodb.table table['id']
    table['total_rows'].should == 0
    table['rows'].should be_empty
  end

  it "should execute a select query and return results" do
    table = @cartodb.create_table 'table #1'

    50.times do
      @cartodb.insert_row table['id'], {
        'name'        => String.random(15),
        'description' => String.random(200),
        'latitude'    => rand(180),
        'longitude'   => rand(360)
      }
    end

    table = @cartodb.table table['id']
    results = @cartodb.query("SELECT * FROM #{table['name']}")
    results.should_not be_nil
    results['time'].should be > 0
    results['total_rows'].should == 50
    results['rows'].should have(50).items
    random_row = results['rows'].sample
    random_row['cartodb_id'].should be > 0
    random_row['name'].should_not be_empty
    random_row['latitude'].should be > 0
    random_row['longitude'].should be > 0
    random_row['description'].should_not be_empty
    random_row['created_at'].should_not be_nil
    random_row['updated_at'].should_not be_nil
  end
end
