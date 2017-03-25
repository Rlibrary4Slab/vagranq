class AuthenticationsController < ApplicationController
  def create
    @authentication = Authentication.from_omniauth(auth_hash, current_user)

    if user_signed_in?
      flash[:notice] = 'Successfully linked that account'
    else
      sign_in @authentication.user, event: :authentication
      flash[:notice] = 'Signed in'
    end

    redirect_to request.env['omniauth.origin'] || root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
