# frozen_string_literal: true

require "rails_helper"

# Rspec for meeting model
RSpec.describe Meeting, type: :model do
  it "should have room" do
    meeting = create_meeting
    expect(meeting).to be_valid
  end

  it "should have user" do
    meeting = create_meeting
    expect(meeting).to be_valid
  end

  context "meeting subject" do
    it "subject must be present" do
      meeting = Meeting.new(
        subject: nil,
        date: "2022-03-15",
        start_time: "10:00 PM",
        end_time: "11:00 PM",
        user: create_user,
        room: create_room,
        meeting_url: ENV["MEETING_URL"]
      )
      expect(meeting).to_not be_valid

      meeting.subject = "ROR Trainee"
      expect(meeting).to be_valid
    end

    it "should raise error" do
      meeting = Meeting.new(
        subject: nil,
        date: "2022-03-15",
        start_time: "10:00 PM",
        end_time: "11:00 PM",
        user: create_user,
        room: create_room,
        meeting_url: ENV["MEETING_URL"]
      )
      meeting.save
      expect(meeting.errors.present?).to be_truthy
    end

    it "should have minimun 5 characters" do
      meeting = create_meeting
      meeting.subject = "abc"

      expect(meeting.valid?).to be_falsy
    end
  end

  context "meeting date" do
    it "should be valid date format" do
      meeting = create_meeting

      expect do
        meeting.date = "2000-2"
        meeting.save!
      end.to raise_error(Date::Error)
    end

    it "should be valid \"2022-03-12\" " do
      meeting = create_meeting
      meeting.date = "2022-03-12"

      expect(meeting.valid?).to be_truthy
    end
  end

  context "meeting time" do
    it "should be valid start time \"10:00 AM\" " do
      meeting = create_meeting
      meeting.start_time = "10:00 AM"

      expect(meeting.valid?).to be_truthy
    end

    it "should not be valid end_time\"00:00\" " do
      meeting = create_meeting
      meeting.end_time = "000:00"

      expect(meeting.valid?).to be_falsy
    end
  end

  context "meeting url" do
    it "\"#{ENV['MEETING_URL']}\" should be valid url" do
      meeting = create_meeting
      meeting.meeting_url = ENV["MEETING_URL"]

      expect(meeting.valid?).to be_truthy
    end

    it "\"this is url\" should not be valid url" do
      meeting = create_meeting
      meeting.meeting_url = "this is url"
      meeting.save

      expect(meeting.errors[:meeting_url][0]).to eq "is invalid"
    end
  end

  # context "associations" do
  #   it { should belong_to(:room).class_name("Room") }
  #   it { should belong_to(:user).class_name("User") }
  # end
end
