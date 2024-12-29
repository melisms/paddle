class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniqueness: { scope: :post_id }
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  after_create_commit :send_like_notification

  private

  def send_like_notification
    LikeNotifier.with(like: self).deliver_later(post.user) # Notify the post owner
  end
end
