class ProfilesController < ApplicationController
  # You must be a user to perform any actions with profiles
  before_action :authenticate_user!
  # The current user can only edit their OWN profile, not anybody else's.
  before_action :only_current_user
  def new
    # Have a form show up, allowing the user to fill out their *OWN* profile info

    # Create instance variable tied to unique user ID
    @user = User.find( params[:user_id] )

    # This build_profile() method becomes available to us because we established the model associations between the users and profiles
    @profile = Profile.new
  end

  def create
    @user = User.find( params[:user_id] )
    @profile = @user.build_profile(profile_params)
    if @profile.save
      flash[:success] = "Profile Updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end

  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end

  def update
    @user = User.find( params[:user_id] )
    @profile = @user.profile
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :edit
    end
  end

  private
  def profile_params
    # Require and only permit the following parameters sent from the profile form
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end
  
  def only_current_user
    @user = User.find( params[:user_id] )
    redirect_to(root_url) unless @user == current_user
  end

end