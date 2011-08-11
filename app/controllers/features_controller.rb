class FeaturesController < ApplicationController
  include FeatureGetterHelper

  before_filter :get_feature, :only => [:show]

  def index
    table = CartoDB::Connection.query "SELECT * FROM #{features_table_name}", :page => 1, :rows_per_page => 20
    @features = table.rows || []
  end

  def show

  end

end
