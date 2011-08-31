class Admin::DashboardController < Admin::AdminController

  def index
    @features_columns = Feature.data_columns
    @features         = Feature.page(1).per_page(1)
    @pages            = Cartoset::Config['pages'].select{|p| p['id'].present? } || []
  end

end