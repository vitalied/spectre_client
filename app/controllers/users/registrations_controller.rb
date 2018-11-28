class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_sign_up_params, only: :create
  before_action :configure_account_update_params, only: :update

  # POST /resource
  def create
    super
  rescue => e
    flash.now[:alert] = e.message
    render :new
  end

  protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end

end
