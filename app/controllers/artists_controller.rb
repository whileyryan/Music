class ArtistsController < ApplicationController

    def follow
        puts params
        @artist = Artist.find(params[:id])
        @user = User.find(current_user.id)
        @user.artists_following << @artist
        respond_to do |format|
            # format.html { redirect_to artist_path}
            format.js { render 'follow', locals:{id: @artist.id}}
        end
    end


    def show
        Dotenv.load
        Rockstar.lastfm = {:api_key => ENV['LASTFM_API_KEY'], :api_secret => ENV['LASTFM_SECRET_KEY']}

        @artist = Artist.find(params[:id])
        @reviews = @artist.reviews
        @mbid = @artist.mbid

        # @artist_search = Rockstar::Artist.new('Ellie Goulding', :include_info => true)
        @artist_search = Rockstar::Artist.new("", :mbid => @mbid, :include_info => true)

        # Add genre into genre table and artist_genres tables
        @genres = @artist_search.tags
        if @genres
            @genres.each do |genre|
                if Genre.exists?(name: genre.to_s)
                    current_genre = Genre.find_by(name: genre.to_s)
                    unless @artist.genres.include?(current_genre)
                        @artist.genres << current_genre
                    end
                else
                    new_genre = Genre.new(name: genre.to_s)
                    if new_genre.save
                        unless @artist.genres.include?(new_genre)
                            @artist.genres << new_genre
                        end
                    end
                end
            end
        end
    end
end
