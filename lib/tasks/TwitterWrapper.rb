require 'httparty'
require 'twitter'

class YelpWrapper
  # BASE_URL = "https://tunes-takeout-api.herokuapp.com/"


  # def self.top_twenty
  #   @results.each do |pair_id|
  #     music = TunesTakeoutWrapper.suggestion_info(pair_id)["suggestion"]
  #
  #     if music["music_type"] == "album"
  #       @album_name   = RSpotify::Album.find(music["music_id"]).name
  #       @album_uri    = RSpotify::Album.find(music["music_id"]).uri
  #       @album_image  = RSpotify::Album.find(music["music_id"]).images[0]["url"]
  #       @album_type   = RSpotify::Album.find(music["music_id"]).album_type
  #       @album_url    = RSpotify::Album.find(music["music_id"]).external_urls['spotify']
  #
  #     elsif music["music_type"] == "artist"
  #       @artist_name  = RSpotify::Artist.find(music["music_id"]).name
  #       @artist_uri   = RSpotify::Artist.find(music["music_id"]).uri
  #       @artist_image = RSpotify::Artist.find(music["music_id"]).images[0]
  #       @artist_type  = RSpotify::Artist.find(music["music_id"]).type
  #       @artist_url   = RSpotify::Artist.find(music["music_id"]).external_urls['spotify']
  #
  #     elsif music["music_type"] == "track"
  #       @track_name   = RSpotify::Track.find(music["music_id"]).name
  #       @track_uri    = RSpotify::Track.find(music["music_id"]).uri
  #       @track_type   = RSpotify::Track.find(music["music_id"]).type
  #       @track_url    = RSpotify::Track.find(music["music_id"]).external_urls['spotify']
  #
  #     else
  #       "Invalid music type."
  #     end
  #   end
  # end

  # def self.find_album(music_id)
  #   RSpotify::Album.find(music_id)
  # end
  #
  # def self.find_artist(music_id)
  #   RSpotify::Artist.find(music_id)
  #   # HTTParty.get(BASE_URL + "v1/suggestions/search?query=" + keyword).parsed_response
  # end
  #
  # def self.find_track(music_id)
  #   RSpotify::Track.find(music_id)
  #   # HTTParty.get(BASE_URL + "v1/suggestions/search?query=" + keyword).parsed_response
  # end
end
