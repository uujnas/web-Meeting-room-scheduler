# frozen_string_literal: true

class Room < ApplicationRecord
  belongs_to :user
  has_many :meetings, dependent: :destroy

  validates :description, presence: true, length: { minimum: 5, maximum: 300 }
end
