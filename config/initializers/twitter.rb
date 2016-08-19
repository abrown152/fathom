<<<<<<< HEAD
require 'twitter'
require 'oauth'

# client = Twitter::REST::Client.new do |config|
#   config.consumer_key = ENV["TWITTER_KEY"]
#   config.consumer_secret = ENV["TWITTER_SECRET"]
#   config.oauth_token = ENV["TWITTER_ACCESS_TOKEN"]
#   config.oauth_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
# end

def prepare_access_token
    consumer = OAuth::Consumer.new(ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"], { :site => "https://api.twitter.com", :scheme => :header })

    # now create the access token object from passed values
    token_hash = { :oauth_token => ENV['TWITTER_ACCESS_TOKEN'], :oauth_token_secret => ENV['TWITTER_ACCESS_TOKEN_SECRET'] }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

    return access_token
=======
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  # This code comes from tutorial http://blog.benmorgan.io/post/79339120263/how-to-use-the-twitter-api-for-ruby-on-rails and states "these are Heroku environment variables" so this might need to be changed since we're not using Heroku.
>>>>>>> 6a3d2a835b1d66104dd24b4ae1f3131494dcc5e9
end
