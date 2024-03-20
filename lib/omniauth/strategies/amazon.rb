require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Amazon < OmniAuth::Strategies::OAuth2
      option :name, 'amazon'

      option :client_options, {
        :site => 'https://www.amazon.com/',
        :authorize_url => 'https://www.amazon.com/b2b/abws/oauth',
        :token_url => 'https://api.amazon.com/auth/o2/token'
      }
    end
  end
end
