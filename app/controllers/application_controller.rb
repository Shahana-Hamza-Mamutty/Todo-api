class ApplicationController < ActionController::API
  include TodolistResponse, Exceptions
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from Exceptions::UnexpectedError,Exceptions::ValidationFailed,
              Exceptions::RecordNotFound, Exceptions::UnAuthorized,
              Exceptions::NoRouteFound, with: :render_error_response


  before_action :authenticate

  def no_route_found
    raise NoRouteFound
  end

  def render_error_response(exception)
    render json: {message: exception.message, status: exception.http_status}, status: exception.http_status
  end

  protected

  # Authenticate the user with token based authentication
  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      token == "aym-te$T"
    end
  end

  def render_unauthorized
    raise UnAuthorized
  end

end
