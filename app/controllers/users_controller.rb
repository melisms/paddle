class UsersController < ApplicationController
  before_action :set_user, only: [ :profile, :edit_profile, :update_profile, :follow, :unfollow ]

  # Profile display
  def profile
    if params[:username].present?
      @user = User.find_by(username: params[:username])
      if @user.nil?
        redirect_to root_path, alert: "User not found"
      end
    else
      @user = current_user
    end
  end

  # Edit profile page
  def edit_profile
  end

  # Update profile
  def update_profile
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      flash.now[:alert] = "Unable to update your profile."
      render :edit_profile
    end
  end

  def follow
    if current_user.follow(@user)
      redirect_to user_profile_path(@user.username), notice: "You are now following #{@user.username}."
    else
      redirect_to user_profile_path(@user.username), alert: "Something went wrong while following #{@user.username}."
    end
  end
  def unfollow
    if current_user.unfollow(@user)
      redirect_to user_profile_path(@user.username), notice: "You have unfollowed #{@user.username}."
    else
      redirect_to user_profile_path(@user.username), alert: "Something went wrong while unfollowing #{@user.username}."
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:profile_picture, :profile_description)
  end
end
