# frozen_string_literal: true

# Request test
require "rails_helper"

RSpec.describe "Rooms", type: :request do
  current_user = User.first_or_create!(email: "amit@bajratexhnologies.com", address: "kathmandu",
                                       contact: "7878787878", role: "admin", password: "password", password_confirmation: "password")

  let(:valid_attributes) do
    {
      id: 1,
      description: "Regarding onboarding on a new project, with new team members",
      user: current_user
    }
  end

  let(:invalid_attributes) do
    {
      description: ""
    }
  end

  describe "GET /index" do
    it "status 200 ok" do
      sign_in current_user
      room = Room.new(valid_attributes)
      room.user = current_user
      room.save!
      get rooms_url
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "status 200 ok" do
      sign_in current_user
      room = Room.new(valid_attributes)
      room.user = current_user
      room.save!
      get room_url(room)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST/ create" do
    context "with valid parameters" do
      it "status 201 created" do
        expect do
          sign_in current_user
          room = Room.new(valid_attributes)
          room.user = current_user
          room.save!
          post rooms_url, params: { post: valid_attributes }
        end.to change(Room, :count).by(1)
      end
    end

    it "redirect to created room" do
      expect do
        sign_in current_user
        post rooms_url, params: { room: valid_attributes }
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "doesnot create room" do
        expect do
          sign_in current_user
          post rooms_path, params: { room: invalid_attributes }
        end.to change(Room, :count).by(0)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroy requested room" do
      sign_in current_user
      room = Room.new(valid_attributes)
      room.user = current_user
      room.save
      expect do
        delete room_url(room)
      end.to change(Room, :count).by(-1)
    end

    it "redirects to the room list" do
      sign_in current_user
      room = Room.new(valid_attributes)
      room.user = current_user
      room.save
      delete room_path(room)
      expect(response).to redirect_to(rooms_url)
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          id: 1,
          description: "Bajra WFH for selective members"
        }
      end

      it "updates the request room" do
        sign_in current_user
        room = Room.new(valid_attributes)
        room.user = current_user
        room.save
        patch room_url(room), params: { room: new_attributes }
        room.reload
      end

      it "redirects to the room" do
        sign_in current_user
        room = Room.new(valid_attributes)
        room.user = current_user
        room.save
        patch room_url(room), params: { room: new_attributes }
        room.reload
        expect(response).to redirect_to(room_url(room))
      end
    end
  end
end
