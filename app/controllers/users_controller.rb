require_dependency "concert"

class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter  :verify_authenticity_token


  def about
    @user = current_user
    @about = params['about']
    @user.update_attributes(:about => params['about'])
    url = "/users/#{@user.id}"
    respond_to do |format|
      if @user.save
        # format.html {redirect_to (url)}
        format.js { render 'update_about'}
      end
    end
  end

  def original_concerts
    concerts_all = Event.limit(10)
    if request.xhr?
        render json: concerts_all.to_json
    end
  end

  def load_concerts
    last_artist_id = params['id'].to_i
    concerts = Event.limit(10).offset(last_artist_id)

    if request.xhr?
        render json: concerts.to_json
    end
  end

  def load_reviews
    review_array = []
    review = Review.limit(10).offset(10)
    new_view = review.as_json
    new_view.each do |view|
      review_array << { :all => view, :user => User.find(view['user_id']), :artist => Artist.find(view['artist_id']) }
    end
    p review_array
    if request.xhr?
      render json: review_array.to_json
    end
  end
   

  def show
    @reviews = Review.limit(10)
    @reviews.each do |view|
      @user = User.find(view['user_id'])
      if @user.image == nil
        @user.update_attributes(image: "http://i.imgur.com/zOKSFwm.jpg")
        @user.save
      end
    end
    @user = current_user
    url = "/users/#{@user.id}"
    if params.include?('current_location')
      @zipcode = params['current_location']
      Event.delete_all
      # @concerts = Concert.storeConcerts(Event.all)
      @concerts = Concert.get_concerts(@zipcode)
      if @concerts != nil
        @concerts = @concerts.limit(10)
      end
    else
      @zipcode = current_user.zipcode
      if @zipcode == nil
        return
      end
      # @concerts = Concert.storeConcerts(Event.all)
      @concerts = Concert.get_concerts(@zipcode)
      if @concerts != nil
        @concerts = @concerts.limit(10)
      end
    end
    # for later
  end

  def store_zipcode
    @user = current_user
    p params
    @user.update_attributes(:zipcode => params[:zip])
    @user.save
    render nothing: true
  end

end
