class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?

     sign_in_and_redirect user
      set_flash_message(:notice, :success, kind: __callee__.to_s.capitalize) if is_navigational_format?
    else
     session["devise.user_attributes"] = user.attributes
     redirect_to new_user_registration_url
    end 
  end
  
  alias_method :twitter ,:all
  alias_method :facebook, :all
  ###
  #def facebook; basic_action; end
  #def github; basic_action; end
  #def google; basic_action; end
  #def hatena; basic_action; end
  #def linkedin; basic_action; end
  #def mixi; basic_action; end
  #def hatena; basic_action; end

  #private
  #def basic_action
  #  @omniauth = request.env['omniauth.auth']
  #  if @omniauth.present?
  #    @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
  #    unless @profile
  #      @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
  #      @profile.user = current_user || User.create!(name: @omniauth['name'])
  #      @profile.save!
  #    end
  #    if current_user
  #      raise "user is not identical" if current_user != @profile.user
  #    else
  #      sign_in(:user, @profile.user)
  #    end
  #    @profile.set_values(@omniauth)
  #  end
  #  render :close, layout: false
  #end
  ###
end
