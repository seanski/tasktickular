class AuthenticatedController < ApplicationController
  check_authorization
  before_filter :check_authentication

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  rescue_from AuthenticationError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def current_user=(user_id)
    @current_user = nil
    session[:user_id] = user_id
  end

  def check_authentication
    raise AuthenticationError if current_user.nil or not current_user.has_valid_authorizations
  end
end
