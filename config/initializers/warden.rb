require 'ostruct'

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.default_strategies :cartodb_oauth
  manager.failure_app = SessionsController
end

class Warden::SessionSerializer
  def serialize(user_hash)
    user_hash
  end

  def deserialize(user_hash)
    OpenStruct.new(user_hash)
  end
end

Warden::Strategies.add(:cartodb_oauth) do
  def authenticate!
    if request.env["omniauth.auth"]
      success!(request.env["omniauth.auth"].slice('uid', 'username', 'email'))
    else
      fail!
    end
  end
end