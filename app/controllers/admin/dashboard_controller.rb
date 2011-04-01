class Admin::DashboardController < Admin::AdminController

  def index
    features_table = CartosetFeature.cartodb_table
    @features_columns = features_table.schema.reject{|c| %w(cartodb_id created_at updated_at).include?(c.first)}.compact
    @features = CartosetFeature.all
  end

end