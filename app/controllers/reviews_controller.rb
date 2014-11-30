class ReviewsController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter  :verify_authenticity_token

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to artist_path
    end
  end

  private
  def review_params
    params.require(:artist_reviews).permit(:artist_id, :user_id, :venue, :content, :music_rating, :atmosphere_rating, :overall_rating, :event_date)
  end
end
