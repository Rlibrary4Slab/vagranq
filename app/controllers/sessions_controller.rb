class SessionsController < ApplicationController
  def new
 
  end

  def callback
    puts request.env['omniauth.auth']
    #if omniauth.present?
      # 認証が成功したときの処理
    #  omniauth = request.env['omniauth.auth']
    #  if omniauth.present?
    #    profile = SocialProfile.find_or_initialize_by(provider: omniauth['provider'], uid: omniauth['uid'])
    #    profile.set_values(omniauth)
        # ...（ユーザ登録、ログイン等をしておく）
    #  end
    #else
      # 認証情報がないときの処理
      # ...（エラーレンダリングとかしておく）
    #end
  end

  def failure
    # 認証が失敗したときの処理（キャンセルを押された時とか）
    # ...（エラーレンダリングとかしておく）
    puts "失敗"
  end

  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
