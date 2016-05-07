class UsersController < ApplicationController
  # You must be a user to perform any actions with profiles
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find( params[:id] )
  end

end