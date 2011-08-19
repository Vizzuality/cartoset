class Admin::PagesController <  Admin::AdminController
  before_filter :get_page, :only => [:show]

  def new
    pages = Cartoset::Config['pages'] || []
    last_page_id = pages.sort{|x,y| y['id'] <=> x['id'] }.first['id'] rescue 0

    @page = OpenStruct.new :id => last_page_id.to_i + 1,
                           :title => t('admin.pages.new.new_page'),
                           :permalink => t('admin.pages.new.permalink')
  end

  def create
    pages = Cartoset::Config['pages'] || []
    pages << params[:page]
    Cartoset::Config.update :pages => pages

    redirect_to admin_path
  end

  def edit
    pages = Cartoset::Config['pages'] || []
    @page = OpenStruct.new pages.select{|p| p['id'].eql?(params[:id])}.first
  end

  def update
    pages = Cartoset::Config['pages'] || []
    pages = pages.reject{|p| p['id'].eql?(params[:page][:id])}

    pages << params[:page]
    Cartoset::Config.update :pages => pages

    redirect_to admin_path
  end

  def show

  end

  def get_page
    #results = CARTODB.query("SELECT * FROM features WHERE cartodb_id = #{params[:id]}") if params[:id]
    #@feature = results.rows.first if results && results.rows.present?
  end
  private :get_page

end
