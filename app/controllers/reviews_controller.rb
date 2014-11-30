class ReviewsController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter  :verify_authenticity_token

  def create

    puts params
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.js {render 'review'}
      end
    end
  end

  private

  def review_params
    params.permit(:artist_id, :user_id, :venue, :content, :music_rating, :atmosphere_rating, :overall_rating, :event_date)
  end

end
