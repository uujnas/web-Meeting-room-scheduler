# frozen_string_literal: true

require "rails_helper"

# RSpec test for meeting controller
RSpec.describe "Meetings", type: :request do
  let(:valid_attributes) do
    {
      subject: "ROR Trainee",
      date: "2022-03-15",
      start_time: "10:00 PM",
      end_time: "11:00 PM",
      user: create_user,
      room: create_room,
      meeting_url: ENV["MEETING_URL"]
    }
  end

  let(:invalid_attributes) do
    {
      subject: "R",
      date: "2022-03-15",
      start_time: "10:00 PM",
      end_time: "11:00 PM",
      room: nil,
      meeting_url: ENV["MEETING_URL"]
    }
  end

  current_user = User.first_or_create!(email: "amit@bajratexhnologies.com", address: "kathmandu",
                                       contact: "7878787878", role: "admin", password: "password", password_confirmation: "password")

  describe "GET /meetings" do
    it "should return ok" do
      sign_in current_user
      get meetings_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /meetings/1" do
    it "should return ok" do
      sign_in current_user
      get meeting_url(create_meeting)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /meetings/1/edit" do
    it "should return :found" do
      get edit_meeting_url(create_meeting)

      expect(response).to have_http_status(:found)
    end
  end

  describe "POST /meetings" do
    context "with valid params" do
      it "should return :created" do
        sign_in current_user
        expect do
          meeting = Meeting.new(valid_attributes)
          # meeting.user = current_user
          # meeting.room = create_room
          meeting.save!

          post meetings_url, params: { meeting: valid_attributes }
        end.to change(Meeting, :create).by(1)
      end

      it "redirect to created room" do
        expect do
          sign_in current_user
          post meetings_url, params: { meeting: valid_attributes }
          expect(response).to be_successful
        end
      end
    end

    context "with invalid parameters" do
      it "should not create meeting" do
        expect do
          sign_in current_user
          post meetings_path, params: { meeting: invalid_attributes }
        end.to change(Meeting, :count).by(0)
      end
    end
  end

  describe "PUT/PATCH /meetings/23" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          subject: "ROR API Session"
        }
      end
      it "should update meeting details" do
        sign_in current_user
        meeting = Meeting.new(valid_attributes)
        meeting.user = current_user
        meeting.save
        patch meeting_url(meeting), params: { meeting: new_attributes }
        meeting.reload
      end

      it "should redirect to the meeting" do
        sign_in current_user
        meeting = Meeting.new(valid_attributes)
        meeting.user = current_user
        meeting.save
        patch meeting_url(meeting), params: { meeting: new_attributes }
        meeting.reload

        expect(response).to redirect_to(meeting_url(meeting))
      end
    end
  end

  describe "DELETE /meetings/1" do
    it "should destroy meeting" do
      sign_in current_user
      meeting = create_meeting

      expect do
        delete meeting_url(meeting)
      end.to change(Meeting, :count).by(-1)
    end

    it "should redirect to meetings list" do
      sign_in current_user
      meeting = Meeting.new(valid_attributes)
      meeting.user = current_user
      meeting.save

      delete meeting_path(meeting)
      expect(response).to redirect_to(meetings_url)
    end
  end
end
