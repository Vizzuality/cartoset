module FeatureGetterHelper

  def get_feature
    @feature = CartoDB::Connection.row Cartoset::Config['features_table'], params[:id]
  end
  private :get_feature

end