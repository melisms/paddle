
class LikeNotifier < ApplicationNotifier

  deliver_by :database, target: ->(like) { like.post.user } # Send notification to the post's user

  # Define the notification content

  def message(recipient)
    "#{@like.user.username} liked your post"
  end

end
