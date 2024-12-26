class UsersController < ApplicationController
  before_action :set_user, only: [:profile, :update]

  # Display the profile
  def profile
    # The @user instance variable is already set by the `set_user` before_action
  end

  # Update the profile
  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile picture updated successfully."
    else
      render :profile, alert: "Unable to update profile picture."
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:profile_picture)
  end
end
