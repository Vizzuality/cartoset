class FeaturesController < ApplicationController
  before_filter :get_feature, :only => [:show]

  def index
    table = CARTODB.table 'features'
    @features = table.rows || []
  end

  def show

  end

  def get_feature
    @feature = CARTODB.query("SELECT * FROM features WHERE id = #{params[:id]}") if params[:id]
  end
  private :get_feature


end
