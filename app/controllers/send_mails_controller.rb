# frozen_string_literal: true

# SendMail Controller
class SendMailsController < DashboardsController
  before_action :authenticate_user!

  def index
    authorize! :update, Meeting
  end
end
