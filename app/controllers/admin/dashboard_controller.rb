class Admin::DashboardController < Admin::AdminController

  def index
    @features_columns = Feature.data_columns
    @features         = CartoDB::Connection.query("SELECT * FROM #{Cartoset::Config['features_table']}", :page => 1, :rows_per_page => 1).rows
    @pages            = Cartoset::Config['pages'].select{|p| p['id'].present? } || []
    @cartodb_host = CartoDB::Settings['host']
    @table_id = CartoDB::Connection.table(Cartoset::Config['features_table']).try(:id)
  end

end