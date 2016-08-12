require 'httparty'

class FathomWrapper
  BASE_URL = "https://api.twitter.com/1.1/statuses/user_timeline.json"

  def self.search
    HTTParty.get(BASE_URL + "?screen_name=Alysia_Brownn&count=2").parsed_response
  end
  #
  # def self.top_twenty
  #   HTTParty.get(BASE_URL + "v1/suggestions/top").parsed_response
  # end
  #
  # def self.suggestion_info(id)
  #   HTTParty.get(BASE_URL + "/v1/suggestions/" + id).parsed_response
  # end
  #
  # def self.favorites
  #   HTTParty.get(BASE_URL + "/v1/users/:#{User.last.uid}/favorites").parsed_response
  #   # Returns a list of pair IDs from Charles' API
  # end
  #
  # def self.favorite(pair_id)
  #   HTTParty.post(BASE_URL + "/v1/users/:#{User.last.uid}/favorites", body: {"suggestions": pair_id}.to_json)
  #   # Currently not saving the favorite in Charles' API, returns an empty array
  #   # work on this
  # end
end
