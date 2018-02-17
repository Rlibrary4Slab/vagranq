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
     puts env["omniauth.auth"]
     if user.week_views.empty?
      user.week_views.build(user_id:user.id, day6:0,day5:0,day4:0,day3:0,day2:0,day1:0,day0:0)
      user.attributes= {day_count_view: 0,certificated: false,count_articles: 0,
all_articles_views: 0,
period_count_articles: 0,
period_articles_views: 0,
total_likes: 0}
      user.save
     end
    end
    # ユーザーがデータベースに保存されており、且つemailを確認済みであれば、ユーザーをログインする。
    #if user.persisted? && user.email_verified?
    if user.persisted? 
      if logged_in?
       redirect_to :back, event: :authentication
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
