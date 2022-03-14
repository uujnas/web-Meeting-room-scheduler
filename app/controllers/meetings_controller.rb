# frozen_string_literal: true

# Meeting Controller
class MeetingsController < DashboardsController
  before_action :authenticate_user!
  before_action :set_meeting, only: %i[show edit update destroy]

  # GET /meetings or
  def index
    @meetings = Meeting.all.group_by(&:room)
  end

  # GET /meetings/1
  def show; end

  # GET /meetings/new
  def new
    authorize! :create, Meeting
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
    authorize! :update, Meeting
  end

  # POST /meetings
  def create
    authorize! :create, Meeting
    @meeting = Meeting.new(meeting_params)

    if @meeting.save
      redirect_to meeting_url(@meeting), notice: "Meeting was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meetings/1
  def update
    authorize! :update, Meeting
    if @meeting.update(meeting_params)
      redirect_to meeting_url(@meeting), notice: "Meeting was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /meetings/1
  def destroy
    authorize! :destroy, Meeting
    @meeting.destroy

    redirect_to meetings_url, notice: "Meeting was successfully destroyed."
  end

  def send_mails
    authorize! :update, Meeting
    @meeting = Meeting.find_by_id(params[:meeting])
    if @meeting
      @meeting.members.each do |member|
        MeetingMailer.with(meeting: @meeting, member: member).send_mail.deliver_now
      end

      redirect_to send_mail_meetings_path, notice: "Mail is sent to all members."
    else
      redirect_to send_mail_meetings_path, alert: "Could not sent mails."
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:subject, :meeting_url, :room_id, :date, :start_time, :end_time, :user_id,
                                    members: [])
  end
end
