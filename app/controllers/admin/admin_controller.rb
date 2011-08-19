class Admin::AdminController < ApplicationController
  before_filter :user_logged?

  layout 'admin'

  def user_logged?
    redirect_to root_url unless logged_in?
  end
  protected :user_logged?
end