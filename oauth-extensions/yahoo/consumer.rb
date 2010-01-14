require 'oauth'

require 'oauth-extensions/yahoo/request_token'

module OAuth
  
  module Yahoo
    
    PATHS = {
      :request_token_path => '/oauth/v2/get_request_token',
      :access_token_path  => '/oauth/v2/get_token',
      :authorize_path     => '/oauth/v2/request_auth'
    }
    
    SITE = 'https://api.login.yahoo.com'
    
    class Consumer
      
      def initialize(api_key, shared_secret)
        @consumer = OAuth::Consumer.new(api_key, shared_secret, PATHS.merge({
          :site => SITE, :scheme => :query_string, :http_method => :get
        }))
      end
      
      def get_request_token
        RequestToken.new(@consumer.get_request_token)
      end
      
    end
    
  end
  
end
