class ApplicationController < ActionController::Base
  
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    protect_from_forgery with: :exception
    
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :designation, :company, :bio])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :designation, :company, :bio])
    end

    private

    def user_not_authorized
        flash[:notice] = "Access denied."
        redirect_to (request.referrer || root_path) 
    end
end