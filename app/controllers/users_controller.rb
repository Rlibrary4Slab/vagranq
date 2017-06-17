class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update,:edit_articles]
  before_action :set_user, only: [ :edit, :update, :like_articles]


  def index
    #@users = User.all
    @users = User.per_page_kaminari(params[:page])
  end




  def show
    if params[:name] != "websocket"
     @user = User.find_by(name: params[:name])
     @articleus = @user.articles.order("created_at desc").per_page_kaminari(params[:page])
     @nuarticleus = @user.articles.published.order("created_at desc").per_page_kaminari(params[:page])
     @title = "自身の投稿"
     @larticles = @user.like_articles
    else
     @user = current_user
    end
  end

  def edit_articles
    @user = User.find_by(name: params[:name])
    @articleus = @user.articles.order("created_at desc").per_page_kaminari(params[:page])
    @title = "投稿編集"
  end

  def share_twitter
    
    current_user.update_attributes(:twitter_s => true)
    flash[:success] = "投稿時Twitterにてシェアされます"
    redirect_to current_user
  end

  def inshare_twitter
    
    current_user.update_attributes(:twitter_s => false)
    flash[:success] = "投稿時Twitterにてシェアされなくなります"
    redirect_to current_user
  end

  def share_facebook
    current_user.update_attributes(:facebook_s => true)
    flash[:success] = "投稿時Facebookにてシェアされます"
    redirect_to current_user
    
  end

  def inshare_facebook
    current_user.update_attributes(:facebook_s => false)
    flash[:success] = "投稿時Facebookにてシェアされなくなります"
    redirect_to current_user
    
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)   
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def finish_signup
    @user = User.find(params[:id])
    if request.patch? && @user.update(user_params)
      @user.send_confirmation_instructions unless @user.confirmed?
      flash[:info] = 'We sent you a confirmation email. Please find a confirmation link.'
      redirect_to root_url
    end
  end
 

  def edit
    #@user = User.find(params[:id])
    @user = User.find_by(name: params[:name])

  end
  
  def update
    #@user = User.find(params[:id])
    @user = User.find_by(name: params[:name])

    if @user.update_attributes(user_params)
       flash[:success] = "Profile updated"
      redirect_to @user# 更新に成功したときの処理
    else
      render 'edit'
    end
  end
  
  def like_articles
    #@articleus = @user.like_articles.page(params[:page])
    @articleus = @user.like_articles.order("created_at desc").per_page_kaminari(params[:page])
    @nuarticleus = @user.like_articles.published.order("created_at desc").per_page_kaminari(params[:page])

    @title = "いいね！一覧"
    render :show
  end
  
  private
  
    def set_user
      @user = User.find_by(name: params[:name])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password,:user_image,:header_image,
                                   :password_confirmation,:twitter_s,:facebook_s)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      #@user = User.find(params[:id])
      @user = User.find_by(name: params[:name])
      redirect_to(root_url) unless @user == current_user
    end
end
