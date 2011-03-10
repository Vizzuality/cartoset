class Admin::SettingsController <  Admin::AdminController
  before_filter :get_setting, :only => [:show]

  def show

  end

  def get_setting
    #results = CARTODB.query("SELECT * FROM features WHERE cartodb_id = #{params[:id]}") if params[:id]
    #@feature = results.rows.first if results && results.rows.present?
  end
  private :get_setting

end
