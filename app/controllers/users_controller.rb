class UsersController < ApplicationController
  before_action :set_user, only: [:profile, :edit_profile, :update_profile]

  # Profile display
  def profile
  end

  # Edit profile page
  def edit_profile
  end

  # Update profile
  def update_profile
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      flash.now[:alert] = 'Unable to update your profile.'
      render :edit_profile
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:profile_picture, :profile_description)
  end
end
