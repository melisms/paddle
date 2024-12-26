class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :profile_description, length: { maximum: 500 }
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :profile_picture

  # Chat associations
  has_many :sent_chats, class_name: "Chat", foreign_key: "sender_id", dependent: :destroy
  has_many :received_chats, class_name: "Chat", foreign_key: "receiver_id", dependent: :destroy

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id", dependent: :destroy

  enum :role, [ :user, :admin ]

  # Associations for following and followers
  has_many :followers, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :following, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :followers, source: :follower
  has_many :followers_users, through: :following, source: :followed

  after_initialize :set_default_role, if: :new_record?
  def all_chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id)
  end
  def follow(user)
    following.create(followed_id: user.id)
  end

  def unfollow(user)
    following.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followed_users.include?(user)
  end
  def set_default_role
    self.role ||= :user
  end

end
