require "./config/initializers/twitter"
require "httparty"
require 'twitter'
require 'excon'
require 'json'
require 'magic_cloud'
require 'rmagick'
require 'area'


class RequestsController < ApplicationController
  # def about
  #   @disclaimer[:notice] = "**Tweet analysis is currently limited to tweets composed in English."
  # end

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

    #Convert user's free form location to state abbreviation.
    if (tweets[0]["user"]["location"].to_zip != nil || tweets[0]["user"]["location"].to_zip == [])
      @user_location = tweets[0]["user"]["location"].to_zip
      if (@user_location.length > 0)
        @user_location = @user_location[0].to_region

        @results_hash["location"] = @user_location[-2, 2]
      end
    end

    puts @results_hash

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

  def trends
    @states = Request.select(:location).map(&:location).uniq
  end

  def show
    # DRY out this method. So ugly.
    @selected_state = params[:state_results][:location]
    @average_anger = 0
    @average_disgust = 0
    @average_fear = 0
    @average_joy = 0
    @average_sadness = 0
    @average_analytical = 0
    @average_confident = 0
    @average_tentative = 0
    @average_openness = 0
    @average_conscientiousness = 0
    @average_extraversion = 0
    @average_agreeableness = 0
    @average_emotional_range = 0

    @state_results = Request.where(["location = :u", { u: params[:state_results][:location] }])

    @state_results.each do |record|
      @average_anger += record.anger
      @average_disgust += record.disgust
      @average_fear += record.fear
      @average_joy += record.joy
      @average_sadness += record.sadness
      @average_analytical += record.analytical
      @average_confident += record.confident
      @average_tentative += record.tentative
      @average_openness += record.openness
      @average_conscientiousness += record.conscientiousness
      @average_extraversion += record.extraversion
      @average_agreeableness += record.agreeableness
      @average_emotional_range += record.emotional_range
    end
    @average_anger = ((@average_anger / @state_results.length)*100).round
    @average_disgust = ((@average_disgust / @state_results.length)*100).round
    @average_fear = ((@average_fear / @state_results.length)*100).round
    @average_joy = ((@average_joy / @state_results.length)*100).round
    @average_sadness = ((@average_sadness / @state_results.length)*100).round
    @average_analytical = ((@average_analytical / @state_results.length)*100).round
    @average_confident = ((@average_confident / @state_results.length)*100).round
    @average_tentative = ((@average_tentative / @state_results.length)*100).round
    @average_openness = ((@average_openness / @state_results.length)*100).round
    @average_conscientiousness = ((@average_conscientiousness / @state_results.length)*100).round
    @average_extraversion = ((@average_extraversion / @state_results.length)*100).round
    @average_agreeableness = ((@average_agreeableness / @state_results.length)*100).round
    @average_emotional_range = ((@average_emotional_range / @state_results.length)*100).round
  end

end
