class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :profile_description, length: { maximum: 500 }
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :profile_picture

  has_many :sent_chats, class_name: "Chat", foreign_key: "sender_id", dependent: :destroy
  has_many :received_chats, class_name: "Chat", foreign_key: "receiver_id", dependent: :destroy

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy

  enum :role, [ :user, :admin ]

  has_many :followers, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :followers, source: :follower
  has_many :followers_users, through: :following, source: :followed

  has_many :pets, dependent: :destroy


  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"


  after_initialize :set_default_role, if: :new_record?
  def all_chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id)
  end
  def follow(user)
    unless following.exists?(followed_id: user.id)
      following.create(followed_id: user.id)
    end
  end

  def unfollow(user)
    following.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.exists?(followed_id: user.id)
  end
  def set_default_role
    self.role ||= :user
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "username" ]
  end
end
