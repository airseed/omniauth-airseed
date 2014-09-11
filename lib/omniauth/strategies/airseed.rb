require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Airseed < OmniAuth::Strategies::OAuth2
      PASSTHROUGHS = %w[
        token
        info
        scope
        service
      ]

      option :name, "airseed"

      option :client_options, {
        :site => "https://auth.airseed.com",
        :authorize_url => "https://auth.airseed.com/oauth/authenticate",
        :token_url => "https://auth.airseed.com/oauth/token"
      }

      def authorize_params
        super.tap do |params|
          PASSTHROUGHS.each do |p|
            params[p.to_sym] = request.params[p] if request.params[p]
          end
        end
      end

      uid { raw_info['user_id'] }

      extra do
        { :raw_info => raw_info }
      end

      info do
        {
            :first_name => raw_info["first_name"],
            :last_name  => raw_info["last_name"],
            :email => raw_info["email"],
            :profile => raw_info["profile"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.airseed.com/v1/users/me').parsed
      end

    end
  end
end
