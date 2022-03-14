# frozen_string_literal: true

# Dashboard Controller
class DashboardsController < ApplicationController
  layout "dashboard"

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
