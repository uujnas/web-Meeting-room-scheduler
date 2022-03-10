class Room < ApplicationRecord
  belongs_to :user

  validates :description, presence: true, length: { minimum: 5, maximum: 300 }
end
