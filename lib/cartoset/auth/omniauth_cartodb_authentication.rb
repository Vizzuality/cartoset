require 'omniauth/oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class Cartodb < OmniAuth::Strategies::OAuth
      def initialize(app, site, app_id, app_secret, options = {})
        @cartodb_options = options
        @cartodb_options[:site] = site
        @cartodb_options[:authorize_path] = '/oauth/authorize'
        @cartodb_options[:access_token_path] = '/oauth/access_token'
        @cartodb_options[:callback_url] = '/auth/oauth/callback'
        super(app, :cartodb, app_id, app_secret, @cartodb_options)
      end
      attr_accessor :cartodb_options

      def consumer
        if CartoDB::Settings.present?
          if @consumer.nil? || @consumer.key != CartoDB::Settings['oauth_key'] || @consumer.secret != CartoDB::Settings['oauth_secret']
            @cartodb_options[:site] = CartoDB::Settings['host']
            @consumer = ::OAuth::Consumer.new(CartoDB::Settings['oauth_key'], CartoDB::Settings['oauth_secret'], @cartodb_options)
          end
        end
        super
      end

      def user_data
        @user_data ||= MultiJson.decode(@access_token.get('/oauth/identity', { 'Accept'=>'application/json' }).body)
      end

      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
          'uid'          => user_data['uid'],
          'username'     => user_data['username'],
          'email'        => user_data['email'],
          'oauth_key'    => user_data['oauth_key'],
          'oauth_secret' => user_data['oauth_secret']
        })
      end
    end
  end
end
