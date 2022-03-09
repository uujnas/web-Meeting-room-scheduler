class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmaion_path_for(_resource_name, resource)
    sign_in(resource)
    cancel_user_registration_path
  end
end
