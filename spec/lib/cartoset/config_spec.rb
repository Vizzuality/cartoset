require 'spec_helper'

describe Config do

  before(:each) do
    @config_path = Rails.root.join('tmp', 'cartoset_config_test.yml')
    FileUtils.rm_f(@config_path) if File.exists?(@config_path)
    Cartoset::Config.path = @config_path
  end

  after(:all) do
    @config_path = Rails.root.join('tmp', 'cartoset_config_test.yml')
    FileUtils.rm_f(@config_path) if File.exists?(@config_path)
  end

  it "should add keys and values" do

    Cartoset::Config.update(:test => 'vizzuality')
    cartoset_config = YAML.load_file(@config_path)
    cartoset_config.should_not be_nil
    cartoset_config['test'].should be == 'vizzuality'
    Cartoset::Config['test'].should be == 'vizzuality'
    Cartoset::Config['test'] = 'cartoset'
    Cartoset::Config['test'].should be == 'cartoset'
  end

  it "should check if cartoset config is valid" do

    Cartoset::Config.update :oauth_key      => 'test',
                            :oauth_secret   => 'test',
                            :app_name       => 'whs',
                            :features_table => 'whs_features'
    Cartoset::Config.should be_valid
  end
end
