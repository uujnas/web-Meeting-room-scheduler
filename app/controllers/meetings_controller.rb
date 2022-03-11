# frozen_string_literal: true

# Meeting Controller
class MeetingsController < DashboardsController
  before_action :authenticate_user!
  before_action :set_meeting, only: %i[show edit update destroy]

  # GET /meetings or
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  def show; end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit; end

  # POST /meetings
  def create
    @meeting = Meeting.new(meeting_params)
    # save_members

    if @meeting.save
      redirect_to meeting_url(@meeting), notice: "Meeting was successfully created."
    else
      # binding.break
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meetings/1
  def update
    if @meeting.update(meeting_params)
      # save_members
      redirect_to meeting_url(@meeting), notice: "Meeting was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /meetings/1
  def destroy
    @meeting.destroy

    redirect_to meetings_url, notice: "Meeting was successfully destroyed."
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:subject, :room_id, :date, :start_time, :end_time, :user_id, members: [])
  end
end
