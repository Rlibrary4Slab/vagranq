class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  #before_action :correct_user,   only: [:edit, :update,:edit_articles]
  before_action :set_user, only: [ :edit, :update, :like_articles]
  helper_method :sort_column, :sort_direction,:sort_gteq,:sort_lteq


  def index
    #@users = User.all
    @users = User.per_page_kaminari(params[:page])
  end

  def access_log_index
    @users_settings=User.all
    #@users = User.per_page_kaminari(params[:page])
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
     params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
    @q = User.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    if params[:q] != {}
     puts params[:q][:s]
     @users = User.per_page_kaminari(params[:page]).order(sort_column + ' ' + sort_direction)
    else
     puts params[:q][:s]
     @users = User.per_page_kaminari(params[:page])
    end
    @orders = @q.result.per_page_kaminari(params[:page])
    #@users = @q.result.per_page_kaminari(params[:page])
    
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
    @weeks_views = [0,0,0,0,0,0,0]
    @user.articles.each do |article| 
       for num in 0..6 do
         page_views_get = REDIS.zscore "user/#{article.user_id}/articles/daily/#{Date.today.advance(:days=>1-(num.to_i)).to_s}", "#{article.id}" 
         @weeks_views[num] += page_views_get.to_i
       end
       @ids = REDIS.zrevrange "user/#{article.user_id}/articles/daily/#{Date.yesterday.to_s}",0,0 
    end 
    @charts = [[Date.today.advance(:days=>-7).strftime("%m/%d"),@weeks_views[6]],[Date.today.advance(:days=>-6).strftime("%m/%d"),@weeks_views[5]],[Date.today.advance(:days=>-5).strftime("%m/%d"),@weeks_views[4]],[Date.today.advance(:days=>-4).strftime("%m/%d"),@weeks_views[3]],[
Date.today.advance(:days=>-3).strftime("%m/%d"),@weeks_views[2]],[
Date.today.advance(:days=>-2).strftime("%m/%d"),@weeks_views[1]],[Date.yesterday.strftime("%m/%d"),@weeks_views[0]]]
    maxviewdigits = Math.log10(@weeks_views.max).to_i #12345 5
    flotview = @weeks_views.max * 0.1 ** maxviewdigits #1.2345
    @floen = BigDecimal(flotview.to_i+1).ceil * 10 ** maxviewdigits #2
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
    
    def sort_column
      params[:q][:s]["0"][:name] || "name"
    end
  
    def sort_direction
     params[:q][:s]["0"][:dir] || "asc"
    end

    def sort_gteq
     params[:q][:created_at_gteq] 
    end

    def sort_lteq
     params[:q][:created_at_lteq] 
    end


  
end
