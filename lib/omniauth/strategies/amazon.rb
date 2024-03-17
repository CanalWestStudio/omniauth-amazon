require 'omniauth-oauth2'
require 'multi_json'
# require 'pry-rails'

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
      #   :scope => 'profile postal_code',
      #   :pkce => true
      # }

      # uid { raw_info['Profile']['CustomerId'] }

      # def raw_info
      #   binding.pry
      #   # access_token.options[:parse] = :json

      #   # This way is not working right now, do it the longer way
      #   # for the time being
      #   #
      #   #@raw_info ||= access_token.get(url).parsed
      #   options[:pkce] = true
      #   url = "/ap/user/profile"
      #   params = {:params => { :access_token => access_token.token}}
      #   @raw_info ||= access_token.client.request(:get, url, params)


      #   # https://api.amazon.com/user/profile?access_token=

      #   # p = JSON.parse(access_token.get("https://api.amazon.com/user/profile").body)
      # end


      def build_access_token
        verifier = request.params['code']

        client.auth_code.get_token(
          verifier,
          { 
            redirect_uri: callback_url 
          }.merge(
            token_params.to_hash(symbolize_keys: true)
          ),
          deep_symbolize(options.auth_token_params)
        )
      end

      def callback_url
        options[:redirect_uri] || full_host + script_name + callback_path
      end
    end
  end
end
