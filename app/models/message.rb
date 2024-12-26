class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  has_one_attached :image

  validates :content, presence: true, unless: -> { image.attached? }
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  scope :unread, -> { where(read: false) }
end
