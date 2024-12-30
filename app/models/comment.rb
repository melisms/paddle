class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  after_create :notify_post_owner

  private

  def notify_post_owner
    # Avoid notifying the post's owner if they commented on their own post
    return if post.user == user

    # Directly deliver the notification here
    CommentNotifier.with(comment: self).deliver(post.user)
  end



end

