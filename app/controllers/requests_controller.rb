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
      # redirect_to analyzed_path
  end

  def about
  end

  def analyzed
  end

end
