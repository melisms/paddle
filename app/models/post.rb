class Post < ApplicationRecord
  validates :body, presence: true, length: { minimum: 1, maximum: 350 }, unless: :photo_attached?

  belongs_to :user
  has_one_attached :photo
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many_attached :media

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  after_save :extract_and_assign_tags

  def tag_names
    tags.pluck(:name).join(", ")
  end

  private

  def extract_and_assign_tags
    hashtag_names = body.scan(/#\w+/).map { |hashtag| hashtag[1..].downcase }.uniq

    self.tags = hashtag_names.map { |name| Tag.find_or_create_by(name: name) }
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "body" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user" ]
  end
  def photo_attached?
    photo.attached?
  end
end
