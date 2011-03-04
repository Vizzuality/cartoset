class Admin::DashboardController < Admin::AdminController

  def index
    @features = CARTODB.table('features')
    @features_columns = (@features.columns.map(&:first) - %w(created_at updated_at)).compact
  end

end