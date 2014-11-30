require 'lastfm'
require 'json'

class SearchController < ApplicationController
  def index

  end

  def show
    # Search artists in application with reviews
    @artists_with_reviews = []
    search_uppercase = params[:search_query].capitalize
    existing_artists = Artist.where("name LIKE ?", "%#{search_uppercase}%")

    if existing_artists.count > 0
      existing_artists.each do |artist|
        if artist.reviews.count > 0
          @artists_with_reviews.push(artist)
        end
      end
    end

    puts "**** Artists with reviews"
    puts @artists_with_reviews.inspect

    # Find remaining artists via Last.fm
    Dotenv.load
    lastfm = Lastfm.new(ENV['LASTFM_API_KEY'], ENV['LASTFM_SECRET_KEY']);
    response = lastfm.artist.search(artist: params[:search_query], limit:10);
    # response = lastfm.artist.getInfo({artist: params[:search_query]}, {api_key: ENV['LASTFM_API_KEY']});
    @results = response['results']['artistmatches']
    @ruby_artists = create_artists(@results)

    # combined results removing duplicate artists
    @prioritize_artists = @artists_with_reviews | @ruby_artists

  end

  private

  def create_artists(json)
    ruby_artists =[]
    artists = []
    puts "********************"
    if json['artist'].kind_of?(Hash)
        artists << json['artist']
    else
        artists = json['artist']
    end

    artists.each do |artist|
      if artist["mbid"] == {}
        puts 'ella sucks'
        next
      end

      if Artist.exists?(mbid: artist["mbid"].to_s )
        ruby_artists.push(Artist.where(mbid: artist["mbid"].to_s ).first)
      else
        artist = Artist.new(name: artist["name"], mbid: artist["mbid"], search_image_url: artist["image"][4]["content"])
        puts artist.inspect
        if artist.save
          ruby_artists.push(artist)
        end
      end
    end

    puts ruby_artists.inspect
    return ruby_artists
  end

end


