module Delicious

  class Post
    attr_accessor :url
    attr_accessor :description
    attr_accessor :extended
    attr_accessor :tags
    attr_accessor :date
    attr_accessor :meta
    attr_accessor :hash
    attr_accessor :others
    attr_accessor :shared

    def initialize(attrs)
      @url = attrs[:url]
      @description = attrs[:description]
      @extended = attrs[:extended]
      @tags = attrs[:tags]
      @date = attrs[:date]
      @meta = attrs[:meta]
      @hash = attrs[:hash]
      @others = attrs[:others]
      @shared = attrs[:shared]
    end

    def self.import_from_xml(xml)
      doc = Nokogiri::XML(xml)
      posts = doc.css('post')
      posts.collect do |post|
        p = Post.new(
          :url => post['href'],
          :description => post['description'],
          :extended => post['extended'],
          :tags => post['tag'].split(' '),
          :date => Time.parse(post['time']),
          :meta => post['meta'],
          :hash => post['hash'],
          :others => post['others'],
          :shared => post['shared']
        )
      end
    end
  end

end
