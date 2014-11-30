module SearchHelper
  def get_review_count(artist)
    return artist.reviews.count
  end
end
