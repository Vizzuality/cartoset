class SessionsController < ApplicationController

  def create
    raise request.env["omniauth.auth"].to_yaml
  end

end
