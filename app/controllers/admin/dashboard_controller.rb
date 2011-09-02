class Admin::DashboardController < Admin::AdminController

  def index
    @search           = OpenStruct.new params[:search]

    search_where      = generate_search_where(@search)

    @page             = (params[:page] || 1).to_i
    @features_columns = Feature.data_columns
    @features_count   = CartoDB::Connection.query("SELECT COUNT(cartodb_id) as features_count FROM #{Cartoset::Config['features_table']} #{search_where}").rows.first.features_count
    @features         = CartoDB::Connection.query(<<-SQL
      SELECT *
      FROM #{Cartoset::Config['features_table']}
      #{search_where}
      LIMIT 10
      OFFSET #{(@page - 1) * 10}
    SQL
    ).rows
    @pages            = (Cartoset::Config['pages'] || []).select{|p| p['id'].present? } || []
    @cartodb_host     = CartoDB::Settings['host']
    @table_id         = CartoDB::Connection.table(Cartoset::Config['features_table']).try(:id)
  end

  def generate_search_where(search_params)
    where = ''

    if search_params && search_params.q.present?
      where = []
      fields = Feature.non_common_fields.select{|f| f[:type] == 'string'}
      fields.each do |f|
        where << "#{f[:name]} ilike '%#{search_params.q.sanitize_sql!}%'"
      end
      where = "WHERE #{where.join(' OR ')}"
    end
    where
  end

end