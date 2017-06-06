class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # いくつプロバイダーを利用しようが処理は共通しているので本メソッドをエイリアスとして流用。
  def callback_for_all_providers
    unless env["omniauth.auth"].present?
      flash[:danger] = "Authentication data was not provided"
      redirect_to root_url and return
    end
    provider = __callee__.to_s
    if logged_in?
     user = OAuthService::GetOAuthUser.logcall(env["omniauth.auth"],current_user)

    else
     user = OAuthService::GetOAuthUser.call(env["omniauth.auth"])
     puts "orange"
    end
    # ユーザーがデータベースに保存されており、且つemailを確認済みであれば、ユーザーをログインする。
    #if user.persisted? && user.email_verified?
    puts "database"
    puts user
    if user.persisted? 
      puts "heln"
      if logged_in?
       redirect_to user, event: :authentication
      else
       sign_in_and_redirect user, event: :authentication
      end
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      user.reset_confirmation!
      flash[:warning] = "We need your email address before proceeding."
      redirect_to finish_signup_path(user)
    end
  end
  alias_method :facebook, :callback_for_all_providers
  alias_method :twitter,  :callback_for_all_providers
  #def twitter; basic_action; end
  #def facebook; basic_action; end

  private
  def basic_action
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).first
      unless @profile
        @profile = SocialProfile.where(provider: @omniauth['provider'], uid: @omniauth['uid']).new
        @profile.user = current_user || User.create!(name: @omniauth['name'])
        @profile.save!
      end
      if current_user
        raise "user is not identical" if current_user != @profile.user
      else
        sign_in(:user, @profile.user)
      end
      @profile.set_values(@omniauth)
    end
    render :close, layout: false
  end

end
