class FeaturesController < ApplicationController
  include FeatureGetterHelper

  before_filter :get_feature, :only => [:show]

  def index
    table = CartoDB::Connection.query "SELECT * FROM #{features_table_name}"
    @features = table.rows || []
  end

  def show

  end

end
