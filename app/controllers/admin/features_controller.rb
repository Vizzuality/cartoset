class Admin::FeaturesController <  Admin::AdminController
  include FeatureGetterHelper

  before_filter :get_feature, :only => [:show]

  def show

  end

  def new
    @features_fields = Feature.non_common_fields
  end

end
