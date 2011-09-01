class Admin::FeaturesController <  Admin::AdminController
  include FeatureGetterHelper

  before_filter :get_feature, :only => [:show, :destroy]

  def show
    @features_fields = Feature.non_common_fields
  end

  def create

    @features_fields = Feature.non_common_fields.map{|f| f[:name]}
    params_for_insert = Hash[params.select{|key| @features_fields.include?(key)}.map{|key, value| [key, value = value.blank?? nil : value]}]

    @new_feature = CartoDB::Connection.insert_row Cartoset::Config['features_table'], params_for_insert

    redirect_to admin_feature_path(@new_feature.cartodb_id)
  end

  def update

    @features_fields = Feature.non_common_fields.map{|f| f[:name]}
    params_for_update = params.select{|key| @features_fields.include?(key)}

    CartoDB::Connection.update_row Cartoset::Config['features_table'], params[:id], params_for_update

    redirect_to admin_feature_path(params[:id])
  end

  def new
    @features_fields = Feature.non_common_fields
  end

  def destroy
    CartoDB::Connection.delete_row Cartoset::Config['features_table'], params[:id]
    redirect_to admin_path
  end

end
