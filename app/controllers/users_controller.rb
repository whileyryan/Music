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
    concerts_all = Concert.storeConcerts(Event.all)
    if request.xhr?
        render json: concerts_all.to_json
    end
  end

  def load_concerts
    
    i = params['id'].to_i
    concerts = Event.where(:id => (i+1 .. i+11))   
    p '='*100
    p concerts
    p '='*100
    if request.xhr?
        render json: concerts.to_json
    end
    # respond_to do |format|
    #   format.json { @concerts.to_json }
    # end
  end
   
  def show
    @reviews = Review.all
    @user = current_user
    url = "/users/#{@user.id}"
    if !params.include?('current_location')
      @zipcode = current_user.zipcode
      # @concerts = Concert.storeConcerts(Event.all)
    # @concerts = Concert.get_concerts(@zipcode)
    else
      @zipcode = params['current_location']
      # @concerts = Concert.storeConcerts(Event.all)
      # @concerts = Concert.get_concerts(@zipcode)
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
   