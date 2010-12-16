require 'rubygems'
require 'delicious-api-via-oauth'
require 'constants'

api = Delicious::API.new(API_KEY, SHARED_SECRET)
api.posts_add!(
  :url => 'http://www.google.com/',
  :description => 'Testing 1 2 3',
  :extended => 'Blah blah blah',
  :tags => 'testing google blah'
)