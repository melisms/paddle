class Post < ApplicationRecord
  validates :body, presence: true, length: { minimum: 1, maximum: 350 }

  belongs_to :user
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
    # Extract hashtags using a regex
    hashtag_names = body.scan(/#\w+/).map { |hashtag| hashtag[1..].downcase }.uniq

    # Associate tags with the post
    self.tags = hashtag_names.map { |name| Tag.find_or_create_by(name: name) }
  end
end
