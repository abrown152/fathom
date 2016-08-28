require "./config/initializers/twitter"
require "httparty"
require 'twitter'
require 'excon'
require 'json'
require 'jqcloud-rails'

class RequestsController < ApplicationController

  def self.call_twitter(handle)
    # Replace underscores in Twitter handles in preparation for URL encoding
    handle.gsub!("_", "%5F")

    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    access_token = prepare_access_token

    # use the access token as an agent to get the user's tweets
    response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + handle + "&count=100")

    tweets = JSON.parse(response.body)

    @results_hash = {}

    @results_hash["username"] = tweets[0]["user"]["screen_name"]

    @results_hash["location"] = tweets[0]["user"]["location"]

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

    RequestsController.call_watson(@user_text)

  end

  def self.call_watson(tweets)
    response = Excon.post("https://gateway.watsonplatform.net/tone-analyzer/api/" + "/v3/tone?version=2016-05-19",
    :headers => {
    "Content-Type" => "text/plain"
    },
    :body => @user_text,
    :password => "iZTY7ZvkKYix",
    :user => "f350af80-6ec2-4b48-8940-9c62b84819cf")

    response = JSON.parse(response.body)

    RequestsController.compile(response)
  end

  def self.compile(response)
    @characteristics_hash = {}

    response["document_tone"]["tone_categories"].each do |result_types|
      result_types["tones"].each do |trait|
        @characteristics_hash[trait["tone_name"]] = trait["score"]
      end
    end

    @words = [
      ["test", 50],
      ["me", 40],
      ["tenderly", 30]
    ]

    @results_hash["traits"] = @characteristics_hash

    # Save new query results to database
    if (Request.find_by(:username => "#{@results_hash["username"]}") == nil)
      Request.create(username: @results_hash["username"],
      location: @results_hash["location"],
      anger: @results_hash["traits"]["Anger"],
      disgust: @results_hash["traits"]["Disgust"],
      fear: @results_hash["traits"]["Fear"],
      joy: @results_hash["traits"]["Joy"],
      sadness: @results_hash["traits"]["Sadness"],
      analytical: @results_hash["traits"]["Analytical"],
      confident: @results_hash["traits"]["Confident"],
      tentative: @results_hash["traits"]["Tentative"],
      openness: @results_hash["traits"]["Openness"],
      conscientiousness: @results_hash["traits"]["Conscientiousness"],
      extraversion: @results_hash["traits"]["Extraversion"],
      agreeableness: @results_hash["traits"]["Agreeableness"],
      emotional_range: @results_hash["traits"]["Emotional Range"]
      )
    end

    return @characteristics_hash

  end

end
