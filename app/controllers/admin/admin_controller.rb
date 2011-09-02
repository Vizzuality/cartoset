class Admin::AdminController < ApplicationController
  before_filter :user_logged?

  layout 'admin'

  def user_logged?
    unless logged_in?
      session[:return_to] = request.request_uri
      redirect_to login_required_path
    end
  end
  protected :user_logged?
end