require "./config/initializers/twitter"
require "httparty"
require 'twitter'

class RequestsController < ApplicationController

  def self.analyze(text)
    response = Unirest.get "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
      headers:{
        "X-Mashape-Key" => ENV["TEST_KEY"],
        "Content-Type" => "application/x-www-form-urlencoded",
        "Accept" => "application/json"
      },
      parameters:{
        "text" => text
      }
      @response = response.body["type"]

  end

  def self.hello
    puts "^_^_^_^_^_^_^_^_^_^_^_^_^_^_^_^"
    r = HTTParty.get("https://api.twitter.com/1.1/search/tweets.json?q=hello")
    # return r
    # puts client.class
    # @client is still nil

    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    access_token = prepare_access_token

    # use the access token as an agent to get the home timeline
    response = access_token.request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=hello")

    return JSON.parse(response["statuses"])
  end

  # hello = @client.user("Alysia_Brownn")

end
