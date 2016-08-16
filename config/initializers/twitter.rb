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
end
