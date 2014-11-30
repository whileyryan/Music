class ArtistsController < ApplicationController

  def show
    Dotenv.load
    Rockstar.lastfm = {:api_key => ENV['LASTFM_API_KEY'], :api_secret => ENV['LASTFM_SECRET_KEY']}

    @artist = Artist.find(params[:id])
    @reviews = @artist.reviews
    puts @artist.inspect
    @mbid = @artist.mbid
    puts @mbid

    # @artist_search = Rockstar::Artist.new('Ellie Goulding', :include_info => true)
    @artist_search = Rockstar::Artist.new(@artist.name, :mbid => @mbid, :include_info => true)
    puts @artist_search.url
    puts @artist_search.inspect

  end
end
