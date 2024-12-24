class Post < ApplicationRecord
    validates :body, presence: true, length: { minimum: 1, maximum: 350 }
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
  
    has_many_attached :media
    def self.ransackable_attributes(auth_object = nil)
      ["body"]
    end
  end
  