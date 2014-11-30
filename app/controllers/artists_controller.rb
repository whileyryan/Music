class ArtistsController < ApplicationController

  def show
    Dotenv.load
    Rockstar.lastfm = {:api_key => ENV['LASTFM_API_KEY'], :api_secret => ENV['LASTFM_SECRET_KEY']}

    @artist = Artist.find(params[:id])
    @reviews = @artist.reviews
    @mbid = @artist.mbid

    # @artist_search = Rockstar::Artist.new('Ellie Goulding', :include_info => true)
    @artist_search = Rockstar::Artist.new(@artist.name, :mbid => @mbid, :include_info => true)
    puts @artist_search.url
    puts @artist_search.inspect

    # Add genre into genre table and artist_genres tables
    @genres = @artist_search.tags
    if @genres
        @genres.each do |genre|
            if Genre.exists?(name: genre.to_s)
                current_genre = Genre.find_by(name: genre.to_s)
                @artist.genres << current_genre
            else
                new_genre = Genre.new(name: genre.to_s)
                if new_genre.save
                    @artist.genres << new_genre
                end
            end
        end
    end
  end
end
