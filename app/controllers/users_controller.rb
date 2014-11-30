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
  	p @user     
  end
end