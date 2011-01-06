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

    # add a new, or update an existing, bookmark
    def posts_add!(parameters)
      posts("add", parameters)
    end

    # delete an existing bookmark
    def posts_delete!(parameters)
      posts("delete", parameters)
    end
    
    # Returns a list of dates with the number of posts at each date.
    # Optionally you can filter by :tag
    def posts_dates(parameters = {})
      posts("dates", parameters)
    end
    
    # Returns one or more posts on a single day matching the arguments. 
    # If no date or url is given, most recent date will be used.
    def posts_get_by_date(parameters = {})
      parameters.merge!(:meta => 'yes')
      parameters.merge!(:dt => Time.now.strftime(DATE_FORMAT))
      response = posts("get", parameters)
      Post.import_from_xml(response.body)
    end

    ##################################################
    private
    
      def posts(action, parameters)
        response = @access_token.get("/v2/posts/#{action}", parameters)
        unless response.is_a?(Net::HTTPOK)
          raise "HTTP response code: #{response.code}"
        end
        unless action =~ /(get|dates|all)/
          matches = Regexp.new('<result code="([^\"]*)" />').match(response.body)
          # puts ">>> response: [#{response.body}]"
          unless matches && matches[1] == 'done'
            raise "Delicious API code: '#{matches[1]}'"
          end
        end
        return response
      end

  end

end
