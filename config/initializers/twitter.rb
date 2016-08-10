twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['TWITTER_KEY']
  config.consumer_secret = ENV['TWITTER_SECRET']
  config.access_token = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  # This code comes from tutorial http://blog.benmorgan.io/post/79339120263/how-to-use-the-twitter-api-for-ruby-on-rails and states "these are Heroku environment variables" so this might need to be changed since we're not using Heroku.
end
