# frozen_string_literal: true
class Meeting < ApplicationRecord
  belongs_to :room
  belongs_to :user
end
