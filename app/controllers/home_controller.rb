class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @username = current_user.username
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new

    #@notifications = current_user.notifications.unread if current_user.present?
  end
end
