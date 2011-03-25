require 'spec_helper'

describe Config do

  it "should add keys and values" do

    Cartoset::Config.update(:test => 'vizzuality')
    cartoset_config = YAML.load_file(Cartoset::Config.path)
    cartoset_config.should_not be_nil
    cartoset_config['test'].should be == 'vizzuality'
    Cartoset::Config['test'].should be == 'vizzuality'
    Cartoset::Config['test'] = 'cartoset'
    Cartoset::Config['test'].should be == 'cartoset'
  end

  it "should check if cartoset config is valid" do

    Cartoset::Config.update :cartodb_oauth_key      => 'test',
                            :cartodb_oauth_secret   => 'test',
                            :app_name       => 'whs',
                            :features_table => 'whs_features'
    Cartoset::Config.should be_valid
  end
end
