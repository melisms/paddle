class Pet < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :location, presence: true
  validates :pet_type, presence: true, inclusion: { in: ['cat', 'dog', 'other'] }
  validates :breed, presence: true, if: -> { ['cat', 'dog'].include?(pet_type) }
end
