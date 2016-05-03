class ProfilesController < ApplicationController
  def new
    # Have a form show up, allowing the user to fill out their *OWN* profile info
    
    # Create instance variable tied to unique user ID
    @user = User.find( params[:user_id] )
    
    # This build_profile() method becomes available to us because we established the model associations between the users and profiles
    @profile = @user.build_profile
  end
  
  def create
    @user = User.find( params[:user_id] )
  end
end