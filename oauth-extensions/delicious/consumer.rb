require 'oauth'

require 'oauth-extensions/yahoo/consumer'

module OAuth
  
  module Delicious
  
    SITE = 'http://api.del.icio.us'
    
    class Consumer
    
      def self.build(api_key, shared_secret)
        OAuth::Consumer.new(api_key, shared_secret, Yahoo::PATHS.merge({
          :site => SITE, :scheme => :header, :http_method => :get, :realm => 'yahooapis.com'
        }))
      end
    
    end
    
  end
  
end
