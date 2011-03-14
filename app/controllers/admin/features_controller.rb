class Admin::FeaturesController <  Admin::AdminController
  include FeatureGetterHelper

  before_filter :get_feature, :only => [:show]

  def show

  end

end
