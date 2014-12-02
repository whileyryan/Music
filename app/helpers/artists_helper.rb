module ArtistsHelper
  def display_genre(artist_search)
    string = ""
    if artist_search.tags.length > 1
      artist_search.tags.each_with_index do |tag,index|
        if index == artist_search.tags.length - 1
          string+= "#{tag}"
        else
          string+= "#{tag}, "
        end
      end

    else
      string = artist_search.tags
    end

    return string
  end

  def display_rating(artist)
    p artist
    if artist.overall_rating
      return "Overall Rating: #{artist.overall_rating}"
    else
      return "No ratings yet!"
    end
  end

  def follow?(artist)
    if current_user.artists_following.include?(artist)
      return true
      # return "<%= button_to 'Following', {}, :disabled => true, :class => 'btn btn-default btn-lg following' %>"
    else
      return false
      # return "<%= button_to 'Follow', artists_follow_path(id: @artist.id), remote: true, :method => :post, :class => 'btn btn-default btn-lg follow' %>"
    end
  end

end
