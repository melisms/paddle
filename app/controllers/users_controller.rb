class UsersController < ApplicationController
  before_action :set_user, only: [ :profile, :edit_profile, :update_profile, :follow, :unfollow, :followers, :following ]

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

  def show
    @user = User.find(params[:id])
    @notifications = @user.notifications
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user unless @user
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
  def followers
    @followers = @user.followed_users
  end
  def following
    @following = @user.followers_users
  end
  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver_later
      redirect_to @user, notice: "User was successfully created."
    else
      render :new
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
