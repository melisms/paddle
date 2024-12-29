class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :notify_post_owner

  private

  def notify_post_owner
    # Avoid notifying the post's owner if they commented on their own post
    return if post.user == user

    CommentNotification.with(comment: self).deliver_later(post.user)
  end
end
