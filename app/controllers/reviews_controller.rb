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

    # calculate and update artist scoring
    @artist = Artist.find(params[:artist_id])
    @reviews = @artist.reviews
    # initialize rating
    @music_rating = 0
    @atmosphere_rating = 0
    @overall_rating = 0
    @composite_rating = 0

    # @reviews.each do |review|
    #   @music_rating += review.music_rating
    #   @atmosphere_rating += review.atmosphere_rating
    #   @overall_rating += review.overall_rating
    #   @composite_rating += review.composite_rating
    # end

    puts "**** Artist Ratings *****"
    puts @music_rating
    puts @atmosphere_rating
    puts @overall_rating
    puts @composite_rating

    # simple average
    @avg_music = @music_rating/@reviews.count
    @avg_atmosphere = @atmosphere_rating/@reviews.count
    @avg_overall = @overall_rating/@reviews.count
    @avg_composite = @composite_rating/@reviews.count

    # update artist's ratings
    @artist.music_rating = @avg_music
    @artist.atmosphere_rating = @avg_atmosphere
    @artist.overall_rating = @avg_overall
    @artist.composite_rating = @avg_composite
    @artist.save
  end

  private

  def review_params
    params.permit(:artist_id, :user_id, :venue, :content, :music_rating, :atmosphere_rating, :overall_rating, :event_date)
  end

end
