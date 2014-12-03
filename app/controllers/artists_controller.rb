class ArtistsController < ApplicationController
    require 'rubygems'
    require 'google/api_client'
    require 'trollop'

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

        # Integrate with Google YouTube
        # Set DEVELOPER_KEY to the "API key" value from the "Access" tab of the
        # Google Developers Console <https://cloud.google.com/console>
        # Please ensure that you have enabled the YouTube Data API for your project.
        opts = Trollop::options do
          opt :q, 'Search term', :type => String, :default => 'Google'
          opt :maxResults, 'Max results', :type => :int, :default => 10
        end

        client = Google::APIClient.new(:key => ENV['YOUTUBE_DEVELOPER_KEY'],
                                       :authorization => nil)
        youtube = client.discovered_api("youtube", "v3")

        # Call the search.list method to retrieve results matching the specified
        # query term.
        opts[:q] = @artist.name + ' live'
        opts[:part] = 'id,snippet'
        search_response = client.execute!(
          :api_method => youtube.search.list,
          :parameters => opts
        )

        @videos = []
        channels = []
        playlists = []

        # Add each result to the appropriate list, and then display the lists of
        # matching videos, channels, and playlists.
        search_response.data.items.each do |search_result|
            p search_result.inspect
          case search_result.id.kind
            when 'youtube#video'
              @videos.push({title: "#{search_result.snippet.title}", video_id: "#{search_result.id.videoId}"})
            when 'youtube#channel'
              channels.push("#{search_result.snippet.title} (#{search_result.id.channelId})")
            when 'youtube#playlist'
              playlists.push("#{search_result.snippet.title} (#{search_result.id.playlistId})")
          end
        end

        puts "Videos:\n", @videos, "\n"
        puts "Channels:\n", channels, "\n"
        puts "Playlists:\n", playlists, "\n"

    end
end
