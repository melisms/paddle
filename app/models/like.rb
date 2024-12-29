class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }

  after_create :notify_post_owner

  private

  def notify_post_owner
    # Avoid notifying the post's owner if they liked their own post
    return if post.user == user

    LikeNotification.with(like: self).deliver_later(post.user)
  end
end
