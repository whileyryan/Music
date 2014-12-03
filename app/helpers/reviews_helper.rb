module ReviewsHelper

  def determine_image(review)
    review.user.image ? review.user.image : "http://i.imgur.com/zOKSFwm.jpg"
  end

  #   def display_rating(artist)
  #     p "*" * 50
  #   p artist
  #   if artist.overall_rating
  #     return "Overall Rating: #{artist.overall_rating}"
  #   else
  #     return "No ratings yet!"
  #   end
  # end
end
