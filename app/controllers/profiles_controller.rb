class ProfilesController < ApplicationController
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
  
  private
  def profile_params
    # Require and only permit the following parameters sent from the profile form
    params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
  end
  
end