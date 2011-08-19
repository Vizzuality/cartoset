class SessionsController < ApplicationController

  skip_before_filter :show_setup_wizard_if_uninstalled, :only => :create

  def new
    if logged_in?
      redirect_to features_path and return
    end
  end

  def create
    Cartoset::Config.set_cartodb_access_token request
    env['warden'].authenticate(:cartodb_oauth)
    redirect_back_or_default root_path
  end

  def destroy
    logout
    redirect_to root_path
  end

  def unauthenticated
    respond_to do |format|
      format.html do
        render :action => 'new' and return
      end
    end
  end

end
