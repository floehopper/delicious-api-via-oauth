require 'test_helper'

# These tests actually make calles to delicious, 
# and they take some time to run because we 
# sleep between calls to avoid pissing off Yahoo.

class TestDelicious < Test::Unit::TestCase
  def setup
    @api ||= Delicious::API.new(API_KEY, SHARED_SECRET)
    @dt ||= Time.now.strftime(DELICIOUS_DATE_FORMAT)
    sleep 1
  end

  should "delete a link" do
    response = @api.posts_delete!(:url => 'http://www.google.com/')
    assert_equal("200", response.code)
  end
  
  should "add a link" do
    response = @api.posts_add!(
      :url => 'http://www.google.com/',
      :description => 'Testing 1 2 3',
      :extended => 'Blah blah blah',
      :tags => 'testing google blah',
      :dt => @dt
    )
    assert_equal("200", response.code)
    sleep 1
    response = @api.posts_add!(
      :url => 'http://www.yahoo.com/',
      :description => 'Yahoo',
      :extended => 'Blah blah blah',
      :tags => 'testing google blah',
      :dt => @dt
    )
    assert_equal("200", response.code)
  end
  
  should "get posts by date" do
    @api.posts_add!(
      :url => 'http://www.google.com/',
      :description => 'Testing Google',
      :extended => 'Blah blah blah',
      :tags => 'testing google blah',
      :dt => @dt
    )
    sleep 1
    @api.posts_add!(
      :url => 'http://www.yahoo.com/',
      :description => 'Testing Yahoo',
      :extended => 'bogus bogus Bogus',
      :tags => 'testing yahoo blah',
      :dt => @dt
    )
    sleep 1
    response = @api.posts_get_by_date(:dt => @dt)
    assert(response.count >= 1)
  end
  
  should "get a list of dates" do
    response = @api.posts_dates
    assert_match(/<date count/, response.body)
  end
  
  should "get all bookmarks" do
    response = @api.get_all_xml
    assert_match(/<posts /, response.body)
  end
  
  should "get post objects from xml" do
    response = @api.get_all_xml
    posts = @api.get_posts_from_xml(response.body)
    assert(posts.count > 0)
  end
  
  should "get a single post object from a URL" do
    @api.posts_add!(
      :url => 'http://www.google.com/',
      :description => 'Testing Google',
      :extended => 'Blah blah blah',
      :tags => 'testing google blah',
      :dt => @dt
    )
    post = @api.get_post_object('http://www.google.com/')
    assert(post[0].is_a?(Delicious::Post))
  end
  
  should "add from a post object" do
    post = Delicious::Post.new(
      :url => "http://www.google.com",
      :description => 'Testing Google',
      :extended => "this is extended text",
      :tags => "testing google blah",
      :date => @dt
    )
    response = @api.add_from_post!(post)
    assert_equal("200", response.code)
  end
end
