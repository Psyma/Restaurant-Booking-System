class ConfirmationsController < Devise::ConfirmationsController
    protected
    def after_sending_reset_password_instructions_path(resource_name)
       redirect_to root_path
    end
  end