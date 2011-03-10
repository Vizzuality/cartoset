class Admin::FeaturesController <  Admin::AdminController
  before_filter :get_feature, :only => [:show]

  def show

  end

  def get_feature
    results = CARTODB.query("SELECT * FROM features WHERE cartodb_id = #{params[:id]}") if params[:id]
    @feature = results.rows.first if results && results.rows.present?
  end
  private :get_feature

end
