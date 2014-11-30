require_dependency "concert"

class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_filter  :verify_authenticity_token


  def show
  	@concerts = Event.all
  	# for later
  	# zipcode = current_user.zipcode
  	# @concerts = Concert.get_concerts(zipcode)
  end

  def store_zipcode
  	@@zipcode = params[:zip]
  	@user = current_user
  	@user.update_attributes(:zipcode => params[:zip])
  	@user.save

  end

  def about
    @user = current_user
    @about = params['current_user']['about']
    @user.update_attributes(:about => params['current_user']['about'])
    url = "/users/#{@user.id}"
    respond_to do |format|
      if @user.save
        # format.html {redirect_to (url)}
        format.js { render 'update_about'}
      end
    end

  end
end
