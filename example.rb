$LOAD_PATH << File.join(File.dirname(__FILE__), 'oauth-extensions')
$LOAD_PATH << File.join(File.dirname(__FILE__), 'delicious')

require 'delicious/api'
require 'constants'

api = Delicious::API.new(API_KEY, SHARED_SECRET)
api.posts_add!(
  :url => 'http://www.google.com/',
  :description => 'Testing 1 2 3',
  :extended => 'Blah blah blah',
  :tags => 'testing google blah'
)