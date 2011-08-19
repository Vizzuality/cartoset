class FeaturesController < ApplicationController
  include FeatureGetterHelper

  before_filter :get_feature, :only => [:show]

  def index
    table = CartoDB::Connection.query "SELECT cartodb_id, title FROM #{features_table_name} LIMIT 20"
    @features = table.rows || []
  end

  def show

  end

end
