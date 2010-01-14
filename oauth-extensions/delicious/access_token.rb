require 'oauth-extensions/delicious/consumer'

module OAuth
  
  module Delicious
    
    class AccessToken
      
      include OAuth::Helper
      
      def initialize(access_token)
        @access_token = access_token
        consumer = @access_token.consumer
        @access_token.consumer = Consumer.build(consumer.key, consumer.secret)
      end
      
      def get(path, parameters = {})
        query = parameters.map { |k, v| "#{escape(k.to_s)}=#{escape(v)}" } * '&'
        components = [path]
        components << query unless query.empty?
        url = components * '?'
        @access_token.get(url)
      end
      
      def save
        File.open('access_token.yml', 'w') do |file|
          file.puts(self.to_yaml)
        end
      end
      
      def self.load
        YAML.load_file('access_token.yml')
      rescue
        nil
      end
      
    end
  
  end
  
end

