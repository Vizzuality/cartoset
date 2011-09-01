class Admin::DashboardController < Admin::AdminController

  def index
    @page             = (params[:page] || 1).to_i
    @features_columns = Feature.data_columns
    @features_count   = CartoDB::Connection.query("SELECT COUNT(cartodb_id) as features_count FROM #{Cartoset::Config['features_table']}").rows.first.features_count
    @features         = CartoDB::Connection.query("SELECT * FROM #{Cartoset::Config['features_table']}", :page => @page, :rows_per_page => 10).rows
    @pages            = Cartoset::Config['pages'].select{|p| p['id'].present? } || []
    @cartodb_host     = CartoDB::Settings['host']
    @table_id         = CartoDB::Connection.table(Cartoset::Config['features_table']).try(:id)
  end

end