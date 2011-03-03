module CartodbHelpers

  def drop_all_cartodb_tables(cartodb_client)
    tables_list = cartodb_client.tables
    tables_list.each do |table|
      cartodb_client.drop_table(table['id']) if table && table['id']
    end
  end

end
RSpec.configuration.include CartodbHelpers