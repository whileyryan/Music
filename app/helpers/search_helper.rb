module SearchHelper

  def get_review_count(artist)
    return artist.reviews.count
  end

  def follow?(artist)
    puts "**********************"
    p current_user
    if current_user.artists_following.include?(artist)
      return true
      # return "<%= button_to 'Following', {}, :disabled => true, :class => 'btn btn-default btn-lg following' %>"
    else
      return false
      # return "<%= button_to 'Follow', artists_follow_path(id: @artist.id), remote: true, :method => :post, :class => 'btn btn-default btn-lg follow' %>"
    end
  end
end
