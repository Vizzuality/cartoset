class FeaturesController < ApplicationController
  include FeatureGetterHelper

  before_filter :get_feature, :only => [:show]

  def index
    table = CartoDB::Connection.table 'features'
    @features = table.rows || []
  end

  def show

  end

end
