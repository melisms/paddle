class NotificationsController < ApplicationController
  before_action :authenticate_user! # Ensure the user is logged in

  # Action to mark a notification as read
  def mark_as_read
    @notification = current_user.notifications.find(params[:id])

    # Mark the notification as read
    @notification.update(read_at: Time.current)

    # Redirect back to the home page or the page you want
    redirect_to root_path, notice: 'Notification marked as read.'
  end
end
