class NotificationsController < ApplicationController
  before_action :authenticate_user! # Optional: only allow authenticated users to view notifications

  def index
    # Fetch notifications for the current user
    @notifications = current_user.notifications.includes(event: :record)
  end

  def mark_as_read
    # Mark a specific notification as read
    notification = NoticedNotification.find(params[:id])
    notification.update(read_at: Time.current)
    redirect_to notifications_path, notice: "Notification marked as read"
  end
end
