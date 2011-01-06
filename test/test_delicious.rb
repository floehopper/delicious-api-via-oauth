require 'test_helper'

# These tests actually make calles to delicious, 
# and they take some time to run because we 
# sleep between calls to avoid pissing off Yahoo.

class TestDelicious < Test::Unit::TestCase
  def setup
    @api = Delicious::API.new(API_KEY, SHARED_SECRET)
    sleep 1
  end
  
  should "delete a link" do
    response = @api.posts_delete!(:url => 'http://www.google.com/')
    sleep 1
    assert_equal("200", response.code)
  end
  
  should "add a link" do
    response = @api.posts_add!(
      :url => 'http://www.google.com/',
      :description => 'Testing 1 2 3',
      :extended => 'Blah blah blah',
      :tags => 'testing google blah'
    )
    assert_equal("200", response.code)
    sleep 1
    response = @api.posts_add!(
      :url => 'http://www.yahoo.com/',
      :description => 'Yahoo',
      :extended => 'Blah blah blah',
      :tags => 'testing google blah'
    )
    assert_equal("200", response.code)
    sleep 1
  end
  
  should "get links" do
    @api.posts_add!(
      :url => 'http://www.google.com/',
      :description => 'Testing Google',
      :extended => 'Blah blah blah',
      :tags => 'testing google blah'
    )
    sleep 1
    @api.posts_add!(
      :url => 'http://www.yahoo.com/',
      :description => 'Testing Yahoo',
      :extended => 'bogus bogus Bogus',
      :tags => 'testing yahoo blah'
    )
    sleep 1
    response = @api.posts_get_by_date
    sleep 1
    assert(response.count >= 2)
  end

  should "get a list of dates" do
    response = @api.posts_dates
    sleep 1
    assert_match(/<date count/, response.body)
  end
end
