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

  def show
    @reviews = Review.all
    @user = current_user
    url = "/users/#{@user.id}"
    if !params.include?('current_location')
      @zipcode = current_user.zipcode
      @concerts = Event.all
    # @concerts = Concert.get_concerts(@zipcode)
    else
      @zipcode = params['current_location']
      @concerts = Event.all
      # @concerts = Concert.get_concerts(@zipcode)
    end
    # for later
  end

  def store_zipcode
    @user = current_user
    @user.update_attributes(:zipcode => params[:zip])
    @user.save
    render nothing: true
  end

end
