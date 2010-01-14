require 'oauth-extensions/yahoo/consumer'
require 'oauth-extensions/yahoo/request_token'
require 'oauth-extensions/delicious/access_token'

module Delicious
  
  class API
    
    def initialize(api_key, shared_secret)
      yahoo_consumer = OAuth::Yahoo::Consumer.new(api_key, shared_secret)
      unless @request_token = OAuth::Yahoo::RequestToken.load
        @request_token = yahoo_consumer.get_request_token
        @request_token.save
      end
      unless @access_token = OAuth::Delicious::AccessToken.load
        oauth_access_token = @request_token.get_access_token
        @request_token.save
        @access_token = OAuth::Delicious::AccessToken.new(oauth_access_token)
        @access_token.save
      end
    end
    
    def posts_add!(parameters)
      response = @access_token.get('/v2/posts/add', parameters)
      unless response.is_a?(Net::HTTPOK)
        raise "HTTP response code: #{response.code}"
      end
      matches = Regexp.new('<result code="([^\"]*)" />').match(response.body)
      unless matches && matches[1] == 'done'
        raise "Delicious API code: '#{matches[1]}'"
      end
      response
    end
    
  end
  
end
