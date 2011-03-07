require 'omniauth/oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class CartodbAuthentication < OmniAuth::Strategies::OAuth
      def initialize(app, site, app_id, app_secret, options = {})
        options[:site] = site
        options[:authorize_path] = '/oauth/authorize'
        options[:access_token_path] = '/oauth/access_token'
        options[:callback_url] = '/auth/oauth/callback'
        super(app, :cartodb_authentication, app_id, app_secret, options)
      end

      def user_data
        @user_data ||= MultiJson.decode(@access_token.get('/oauth/identity.json').body)
      end

      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
          'uid' => user_data['uid'],
          'username' => user_data['username'],
          'email' => user_data['email']
        })
      end
    end
  end
end