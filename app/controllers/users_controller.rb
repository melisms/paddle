class UsersController < ApplicationController
  before_action :set_user, only: [:profile, :update]

  def profile
  end

  def update
    if @user == current_user && @user.update(user_params)
      redirect_to users_profile_path, notice: 'Profile updated successfully.'
    else
      render :profile, alert: 'Unable to update profile.'
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