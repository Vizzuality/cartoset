class Admin::DashboardController < Admin::AdminController

  def index
    @features_columns = Feature.data_columns
    @features         = Feature.all
  end

end