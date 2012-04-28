class AuthenticatedController < ApplicationController
  check_authorization
  before_filter :check_authentication

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  rescue_from AuthenticationError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def check_authentication
    raise AuthenticationError if current_user.nil? or not current_user.has_valid_authorizations?
  end
end
