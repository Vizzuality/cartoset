class FeaturesController < ApplicationController

  def index
    features_table = CARTODB.table('features')
    @features = features_table.rows || []
  end

end
