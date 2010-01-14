require 'yaml'

module OAuth
  
  module Yahoo
    
    class RequestToken
    
      def initialize(request_token)
        @request_token = request_token
      end
      
      def get_oauth_verifier
        return @oauth_verifier if @oauth_verifier
        `open #{@request_token.authorize_url}`
        puts 'Sign-in to Yahoo in the browser to allow access to this application'
        puts 'And then enter the supplied oauth_verifier :-'
        @oauth_verifier = gets.chomp
      end
      
      def get_access_token
        @request_token.get_access_token(:oauth_verifier => get_oauth_verifier)
      end
      
      def save
        File.open('request_token.yml', 'w') do |file|
          file.puts(self.to_yaml)
        end
      end
      
      def self.load
        YAML.load_file('request_token.yml')
      rescue
        nil
      end
      
    end
    
  end
  
end