class SessionsController < ApplicationController
  def create
    @user = current_user
    @auth = Authorization.find_or_create_from_auth_hash(auth_hash, @user)
    self.current_user = @auth.user.id
    MQ.publish(@auth.registration_dump)
    redirect_to(self.current_user)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
