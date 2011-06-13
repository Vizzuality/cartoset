class Feature < CartoDB::Model::Base
  cartodb_table_name Cartoset::Config['features_table']

  def self.non_common_fields
    columns.reject{|c| Cartoset::Constants::COMMON_FEATURES_FIELDS.include?(c[:name])}
  end
end