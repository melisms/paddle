class LikeNotification < Noticed::Base
  deliver_by :database  # Stores notifications in the database

  param :like  # Pass the like object as a parameter

  # Define the message for the notification
  def message
    "#{params[:like].user.username} liked your post."
  end

  # Define the URL that the notification should link to
  def url
    Rails.application.routes.url_helpers.post_path(params[:like].post)
  end
end
