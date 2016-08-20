require "./config/initializers/twitter"
require "httparty"
require 'twitter'
require 'excon'

class RequestsController < ApplicationController

  def self.analyze(handle)
    # Replace underscores in Twitter handles in preparation for URL encoding
    handle.gsub!("_", "%5F")

    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    access_token = prepare_access_token

    # use the access token as an agent to get the user's tweets
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + handle + "&count=100")

    tweets = JSON.parse(response.body)

    # Compile all tweet text into a single string for analysis
    @user_text = ""
    tweets.each do |tweet|
      @user_text = @user_text + " " + tweet["text"]
    end

    # Remove Twitter handles and hashtags from text to be analyzed
    @word_array = @user_text.split(" ")
    @word_array.each do |word|
      if word[0] == "@" || word[0] == "#"
        @word_array.delete(word)
      end
    end
    @user_text = @word_array.join(" ")

    @user_text = @user_text[0...2000]

    # response = Unirest.get "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
    #   headers:{
    #     "X-Mashape-Key" => ENV["TEST_KEY"],
    #     "Content-Type" => "application/x-www-form-urlencoded",
    #     "Accept" => "application/json"
    #   },
    #   parameters:{
    #     "text" => @user_text
    #   }
    #   @response = response.body["type"]



    # @user_text = "hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello hello"

      response = Excon.post("https://gateway.watsonplatform.net/tone-analyzer/api/",
        headers:{
          "Content-Type" => "plain/text"
        },
        :body => @user_text,
        :password => "iZTY7ZvkKYix",
        :user => "f350af80-6ec2-4b48-8940-9c62b84819cf")


        @response = response.body





      return response.body
  end
  #
  # Watson API Call:


# Watson API Credentials:
#   {
#   "credentials": {
#     "url": "https://gateway.watsonplatform.net/tone-analyzer/api",
#     "password": "iZTY7ZvkKYix",
#     "username": "f350af80-6ec2-4b48-8940-9c62b84819cf"
#   }
# }


  def search
    @search_results = FathomWrapper.search
  end

end
