class ApplicationController < ActionController::API
  rescue_from Exception, with: :error_500
  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActionController::RoutingError, with: :error_404
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ActionController::Cookies
  include DeviseTokenAuth::Concerns::SetUserByToken

  def error_404
    render json: { status: false, errors: ['Not Found'] }
  end

  def error_500(error)
    render json: { status: false, errors: [error] }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday])
  end
end
