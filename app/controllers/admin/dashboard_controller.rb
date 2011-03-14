class Admin::DashboardController < Admin::AdminController

  def index
    @features = CartoDB::Connection.table('features')
    @features_columns = @features.columns.reject{|c| %w(cartodb_id created_at updated_at).include?(c.first)}.compact
  end

end