class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  before_save :downcase_name

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
  before_save :downcase_name
  private
  def downcase_name
    self.name = name.downcase
  end
end
