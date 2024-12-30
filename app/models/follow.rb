class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User", counter_cache: :following_count
  belongs_to :followed, class_name: "User", counter_cache: :followers_count

  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :cannot_follow_self

  private

  def cannot_follow_self
    if follower_id == followed_id
      errors.add(:base, "You cannot follow yourself.")
    end
  end
end
