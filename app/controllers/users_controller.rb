# frozen_string_literal: true

# User Controller
class UsersController < DashboardsController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    @meeting = Meeting.all
  end
end
