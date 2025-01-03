class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  has_one_attached :image

  validates :content, presence: true, unless: -> { image.attached? }
  validates :sender_id, presence: true
  validates :receiver_id, presence: true

  scope :unread, -> { where(read: false) }

  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

  after_create :notify_receiver

  private

  def notify_receiver
    # Avoid notifying the sender about their own message
    return if sender == receiver

    # Ensure the notifier is called correctly
    MessageNotifier.with(message: self).deliver(receiver)
  end
end
