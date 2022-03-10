# frozen_string_literal: true

class Meeting < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :subject, presence: true, length: { minimum: 5 }

  validates_presence_of :date, :start_time, :end_time

  # after_initialize do
  #   start_time = Time.parse(self.start_time.to_s)
  #   self.start_time = start_time.strftime("%H:%M %p")
  #   end_time = Time.parse(self.end_time.to_s)
  #   self.end_time = end_time.strftime("%H:%M %p")
  # end

  def time_format(time)
    Time.parse(time.to_s).strftime("%H:%M %p")
  end

  before_save do
    self.subject = subject.titleize
  end
end
