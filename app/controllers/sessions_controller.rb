class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to features_path and return
    end
  end

  def create
    env['warden'].authenticate(:cartodb_oauth)
    redirect_to features_path
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
