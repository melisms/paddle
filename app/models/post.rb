class Post < ApplicationRecord
    # validates :title, presence: true, length: { minimum: 5, maximum: 50 }
    validates :body, presence: true, length: { minimum: 1, maximum: 350 }
    belongs_to :user
end
