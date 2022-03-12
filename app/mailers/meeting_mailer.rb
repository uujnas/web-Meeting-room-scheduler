# frozen_string_literal: true

# MeetingMailer to send meeting details to members
class MeetingMailer < ApplicationMailer
  default from: "bikashshrestha@bajratechnologies.com"

  def send_mail
    @meeting = params[:meeting]
    @member = User.find_by_email(params[:member])
    @url = ENV["MEETING_URL"]

    mail(to: @member.email, subject: @meeting.subject)
  end
end
