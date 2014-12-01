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
    if artist.overall_rating
      return "Overall Rating: #{artist.overall_rating}"
    else
      return "No ratings yet!"
    end
  end

end
