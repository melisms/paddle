class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    feed = Feed.new(@user)
    @posts = feed.fetch_feed
    @username = current_user.username
    @post = Post.new

    @notifications = current_user.notifications.unread if current_user.present?
  end
end
