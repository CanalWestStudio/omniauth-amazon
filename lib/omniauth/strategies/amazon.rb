require 'omniauth-oauth2'
require 'multi_json'
require 'pry-rails'

module OmniAuth
  module Strategies
    class Amazon < OmniAuth::Strategies::OAuth2
      option :name, 'amazon'

      option :client_options, {
        :site => 'https://www.amazon.com/',
        :authorize_url => 'https://www.amazon.com/b2b/abws/oauth',
        :token_url => 'https://api.amazon.com/auth/o2/token'
      }

      option :access_token_options, {
        :mode => :query
      }

      # option :authorize_params, {
      #   :scope => 'profile postal_code'
      # }

      def authorize_params
        {
          applicationId: options[:application_id],
          redirect_uri: callback_url,
          state: options[:state],
          scopea: 'profile postal_code',

        }
      end

      def token_params
        {
          redirect_uri: callback_url,
          client_id: client.id,
          client_secret: client.secret,
          code: request.params['code'],
          grant_type: 'authorization_code'
        }
      end

      # def build_access_token
      #   token_params = {
      #     :redirect_uri => callback_url.split('?').first,
      #     :client_id => client.id,
      #     :client_secret => client.secret
      #   }
      #   verifier = request.params['code']
      #   client.auth_code.get_token(verifier, token_params)
      # end

      def build_access_token
        # binding.pry
        verifier = request.params['code']
        client.auth_code.get_token(verifier, token_params)
      end

      uid { raw_info['Profile']['CustomerId'] }

      info do
        {
          'email' => raw_info['Profile']['PrimaryEmail'],
          'name' => raw_info['Profile']['Name']
        }
      end

      extra do
        {
          'postal_code' => raw_info['Profile']['PostalCode']
        }
      end

      def raw_info
        # binding.pry
        access_token.options[:parse] = :json

        # This way is not working right now, do it the longer way
        # for the time being
        #
        #@raw_info ||= access_token.get('/ap/user/profile').parsed

        url = "/users/auth/amazon"
        params = {:params => { :access_token => access_token.token}}
        @raw_info ||= access_token.client.request(:get, url, params).parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
