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
      response = posts("get", parameters)
      Post.import_from_xml(response.body)
    end
    
    def get_all_xml(parameters = {})
      parameters.merge!(:meta => 'yes')
      response = posts("all", parameters)
    end

    def get_all_posts(parameters = {})
      parameters.merge!(:meta => 'yes')
      response = posts("all", parameters)
      Post.import_from_xml(response.body)
    end

    def get_posts_from_xml(xml)
      Post.import_from_xml(xml)
    end
    
    def get_post_object(url)
      parameters = {:url => url, :meta => 'yes'}
      response = posts("get", parameters)
      Post.import_from_xml(response.body).first
    end

    def add_from_post!(post_object)
      parameters = {
        :url => post_object.url, 
        :description => post_object.description,
        :extended => post_object.extended,
        :tags => post_object.tags.is_a?(Array) ? post_object.tags.join(" ") : post_object.tags,
        :dt => post_object.date,
        :replace => 'yes',
        :shared => post_object.shared
      }
      response = posts("add", parameters)
    end

    ##################################################
    private

      def posts(action, parameters)
        response = @access_token.get("/v2/posts/#{action}", parameters)
        unless response.is_a?(Net::HTTPOK)
          raise "HTTP response code: #{response.code}"
        end
        if action =~ /(add|delete)/
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
