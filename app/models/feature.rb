class Feature < CartoDB::Model::Base
  cartodb_table_name Cartoset::Config['features_table']
end