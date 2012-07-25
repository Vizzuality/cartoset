class Admin::AdminController < ApplicationController

  before_filter :user_valid?

  layout 'admin'

  def user_valid?
    if logged_in?
      redirect_to root_path, :notice => t('.invalid_account') unless Cartoset::Config.valid_user?(current_user)
    else
      session[:return_to] = request.request_uri
      redirect_to login_required_path
    end
  end
  protected :user_valid?

end
