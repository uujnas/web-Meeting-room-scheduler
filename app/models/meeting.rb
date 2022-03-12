# frozen_string_literal: true

# Meeting Model
class Meeting < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :subject, presence: true, length: { minimum: 5 }

  validates_presence_of :date, :start_time, :end_time

  validates_format_of :meeting_url, with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i

  validate :meeting_start_date

  validate :schedule

  validate :start_and_end_time

  def time_format(time)
    Time.parse(time.to_s).strftime("%H:%M %p")
  end

  before_save do
    self.subject = subject.titleize
  end

  def start_and_end_time
    if Date.parse(date.to_s) < Date.parse(Time.now.to_s) && (Time.parse(start_time.to_s) < Time.now)
      errors.add(:start_time, "can't be in the past!")
    end
    # puts "&&&&&&", end_time < start_time
    errors.add(:start_time, "cant' start before end time!") if end_time < start_time
    errors.add(:end_time, "start time and end time can't be same") if start_time == end_time
  end

  def meeting_start_date
    errors.add(:date, "Can't be in the past!") if Date.parse(date.to_s) < Date.parse(Time.now.to_s)
  end

  def schedule
    data = Meeting.select(:start_time, :end_time, :id).where(date: date).where.not(id: id).where(room_id: room_id)
    # puts "#{date} = #{start_time}= #{end_time}"
    data.each do |meeting|
      # puts meeting.start_time, meeting.end_time, "**" * 20

      # puts meeting.start_time.hour, start_time.hour, "###" * 10

      errors.add(:start_time, "Meeting is scheduled before another meeting is over!") if start_time < meeting.end_time

      if meeting.start_time.hour == start_time.hour && (start_time.min <= meeting.end_time.min)
        errors.add(:start_time, "Meeting has already been schedule on this time!!")
      end
    end
  end
end
