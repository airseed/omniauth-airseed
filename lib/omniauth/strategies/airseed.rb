require 'omniauth/strategies/oauth2'


module OmniAuth
  module Strategies
    class Airseed < OmniAuth::Strategies::OAuth2
      BASE_URL = "https://auth.airseed.com"
      PASSTHROUGHS = %w(state scope redirect_uri provider)

      option :name, "airseed"

      option :client_options, {
        :site => BASE_URL,
        :authorize_url => "#{BASE_URL}/oauth/authenticate",
        :token_url => "#{BASE_URL}/oauth/token"
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
