require "./config/initializers/twitter"
require "httparty"
require 'twitter'

class RequestsController < ApplicationController

  def self.analyze(handle)
    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    access_token = prepare_access_token

    # Replace underscores in Twitter handles in preparation for URL encoding
    handle.gsub!("_", "%5F")

    # use the access token as an agent to get the user's tweets
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + handle + "&count=100")

    tweets = JSON.parse(response.body)

    return tweets

    user_text = ""

    tweets.each do |tweet|
      user_text + tweet["text"]
      #
      # tweet_array = tweet_text.split(" ")
      # tweet_array.each do |word|
      #   if word[0] == "@" || word[0] == "#"
          # puts word # this is working but hashtag and handle removal isn't
          # tweet_array.delete(word)
          # tweet_text = tweet_array.join(" ")
          # puts tweet_text
        # end
      # end
      #
      # if tweet["text"][0] == "R" && tweet["text"][1] == "T"
      #   tweets.delete(tweet)
      # end
    end


    # returns most recent 100 tweets
    # return tweets

    tweets.each do |tweet|
      tweet_string + " " + tweet["text"]
    end

    # puts tweet_string






    response = Unirest.get "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
      headers:{
        "X-Mashape-Key" => ENV["TEST_KEY"],
        "Content-Type" => "application/x-www-form-urlencoded",
        "Accept" => "application/json"
      },
      parameters:{
        "text" => tweet_string
      }
      @response = response.body["type"]
  end

<<<<<<< HEAD

  # def self.pull_tweets(handle)
  #   # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
  #   access_token = prepare_access_token
  #
  #   handle.gsub("_", "%20")
  #
  #   # use the access token as an agent to get the home timeline
  #   response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + handle + "&count=100")
  #
  #
  #   tweets = JSON.parse(response.body)
  #   tweets.each do |tweet|
  #     tweet_text = tweet["text"]
  #     tweet_array = tweet_text.split(" ")
  #     tweet_array.each do |word|
  #       if word[0] == "@" || word[0] == "#"
  #         puts word # this is working but hashtag and handle removal isn't
  #         # tweet_array.delete(word)
  #         # tweet_text = tweet_array.join(" ")
  #         # puts tweet_text
  #       end
  #     end
  #
  #     if tweet["text"][0] == "R" && tweet["text"][1] == "T"
  #       tweets.delete(tweet)
  #     end
  #   end
  #
  #   # returns most recent 100 tweets
  #   return tweets
  # end
=======
  def search
    @search_results = FathomWrapper.search
  end
>>>>>>> 6a3d2a835b1d66104dd24b4ae1f3131494dcc5e9

end
