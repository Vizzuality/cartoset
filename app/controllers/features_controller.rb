class FeaturesController < ApplicationController
  include FeatureGetterHelper

  before_filter :get_feature, :only => [:show]

  def index
    table = CartoDB::Connection.query "SELECT cartodb_id, title, ST_Centroid(the_geom) as the_geom FROM #{features_table_name} LIMIT 20"
    @features = table.rows || []
    @features_json = @features.map{|f| {:title => f.title, :latitude => f.the_geom.y, :longitude => f.the_geom.x}}.to_json.html_safe
  end

  def show
    debugger
  end

end
