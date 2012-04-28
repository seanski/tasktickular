class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) rescue nil
  end

  def current_user=(user_id)
    @current_user = nil
    session[:user_id] = user_id
  end
end
