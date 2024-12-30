class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Fetch notifications for the current user
    @notifications = current_user.notifications.includes(event: :record)
  end

  def mark_as_read
    # Fetch the notification
    notification = current_user.notifications.find_by(id: params[:id])

    # If the notification exists and is unread, mark it as read
    if notification && notification.read_at.nil?
      notification.update(read_at: Time.current)
      redirect_to notifications_path, notice: "Notification marked as read"
    else
      redirect_to notifications_path, alert: "Notification not found or already read"
    end
  end
end
