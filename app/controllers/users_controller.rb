class UsersController < ApplicationController
  before_action :set_user, only: [ :profile ]
  def profile
  end
  private
  def set_user
    @user = current_user
  end
end
