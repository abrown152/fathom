class RequestsController < ApplicationController

  def analyze
    response = Unirest.post "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
      headers:{
        "X-Mashape-Key" => ENV["TEST_KEY"],
        "Content-Type" => "application/x-www-form-urlencoded",
        "Accept" => "application/json"
      },
      parameters:{
        "text" => params[:q]
      }
      raise
      response.body
  end

  def about
  end

end
