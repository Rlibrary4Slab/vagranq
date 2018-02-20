class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: [ :edit, :update, :like_articles,:show,:edit_articles]
  #before_action :correct_user,   only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update,:edit_articles]
#  before_action :admin_user?, only: [ :edit, :update, :like_articles,:edit_articles,:access_log_index]
  helper_method :sort_column, :sort_direction,:sort_gteq,:sort_lteq
 


  def index
    puts Time.now.to_s+" "+Time.now.hour.to_s+":"+Time.now.min.to_s+":"+Time.now.sec.to_s
    #@users = User.all
    #@users.each do |user|
       #user.update_columns(day_count_view: user.period_articles_views)
       #wv =  user.week_views.first
       #yesterday_views = wv.day0
    #end 

    #@uPeriodView = User.per_page_kaminari(params[:page]).order("day_count_view desc")
    @uPeriodView = User.per_page_kaminari(params[:page]).with_not_regexp("name", "guest00[0-9+]+").order("day_count_view desc")

  end

  def access_log_index
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
     params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
    @user = User.find(5)
    #puts User.where("day_count_view<60000").maximum(:day_count_view) 
    #puts User.where("day_count_view>0").minimum(:day_count_view)
    #puts User.average(:day_count_view).to_i
    liking_users_count =0
    #User.all.each do |user|
      #liking_users_count += article.liking_users.count  
    #  user.articles.each do |article| 
    #   REDIS.zincrby "user/#{article.user_id}/likes/daily/#{Date.today.to_s}", article.liking_users.count, "#{article.id}"
    #   REDIS.zincrby "user/#{article.user_id}/likes", article.liking_users.count, "#{article.id}"
    #  end
    #end
    #puts liking_users_count
    total_more_100_view = 0
    
    user_articles_views = REDIS.zrevrange "user/#{@user.id}/articles",0 ,-1,with_scores: true
    redis_counting = REDIS.zrevrange "user/#{@user.id}/articles",0 ,-1
    #puts "ユーザーが所持する全投稿とView数"
    #puts user_articles_views
    #puts redis_counting.count
    user_articles_views.each do |view|
         
        total_more_100_view+=1 if view.last.to_i >= 100
    end
    puts total_more_100_view.to_d/redis_counting.count.to_d
    #arek = REDIS.keys "user/5/ar*"
    #arek = REDIS.zrevrangebyscore "user/5/articles","+inf","-inf" 
    #puts arek.count
    @q = User.ransack(params[:q])
    @q.build_sort if @q.sorts.empty?
    if params[:q] != {}
     @users = User.with_not_regexp("name", "guest00[0-9+]+").order(sort_column + ' ' + sort_direction).per_page_kaminari(params[:page])
     @users.each do |user|
      keys = []
      beting =0
      
      if sort_gteq != 0           
        (sort_gteq.to_date..sort_lteq.to_date).each do |date| 
	  #検索した日の間までの記事を取得させる準備
    
          keys.concat(["user/#{user.id}/articles/daily/#{date.to_s}"]) 
         end #date 

            #puts "このユーザーの#{sort_gteq}から#{sort_lteq}までの期間変数が定まっていないため"
        REDIS.zunionstore "user/#{user.id}/articles/betweendays/#{sort_gteq}/#{sort_lteq}", keys 
      end # if
       betweens=  REDIS.zrevrange "user/#{user.id}/articles/betweendays/#{sort_gteq}/#{sort_lteq}", 0,-1,with_scores: true   #ユーザー全公開投稿ID取得 View数を取得　

       period = 0 

       betweens.each do |between|
         period += between.last.to_i
       end # between
      sum_of_views =0
      
     
      all_users_view =REDIS.zrevrange "user/#{user.id}/articles", 0, -1, withscores: true
     all_users_view.each do |view|
      sum_of_views+=view.last.to_i
     end
     #conting_article = user.articles.count || 
     redis_article_counts = REDIS.zrevrangebyscore "user/#{user.id}/articles","+inf","-inf" 
     
    #  user.update_columns(period_articles_views: period.to_i,
                          #all_articles_views: sum_of_views,
                          #count_articles: redis_article_counts.count,
                          #period_count_articles: user.articles.published.where(created_at: sort_gteq..sort_lteq).count) #投稿された「期間内の投稿」の総View
    
     end #user
     @users = User.per_page_kaminari(params[:page]).with_not_regexp("name", "guest00[0-9+]+").order(sort_column + ' ' + sort_direction)
    else
     @users = User.with_not_regexp("name", "guest00[0-9+]+").per_page_kaminari(params[:page])
    end 
  end


  def show
     
    if params[:name] != "websocket"
     #puts  REDIS.zrevrange "user/#{user.id}/articles/betweendays/#{sort_gteq}/#{sort_lteq}", 0,-1
     #keys = []
     #(2017-12-01.to_date..2017-12-12.to_date).each do |date|
          #検索した日の間までの記事を取得させる準備
   
     #     keys.concat(["user/#{user.id}/articles/daily/#{date.to_s}"])
     #end 
     #countviewmorehundred = REDIS.zcount "user/#{@user.id}/articles", 100, "+inf" 
     #countviewmoretwohundred = REDIS.zcount "user/#{@user.id}/articles", 200, "+inf" 
     #countviewmorethousand = REDIS.zcount "user/#{@user.id}/articles", 1000, "+inf" 
     #countlikemorethree = REDIS.zcount "user/#{@user.id}/likes", 3, "+inf" 
     #countlikemorefive = REDIS.zcount "user/#{@user.id}/likes", 5, "+inf" 
     #countlikemoreten = REDIS.zcount "user/#{@user.id}/likes", 10, "+inf" 
     #puts countviewmorehundred,countviewmorehundred > 3 
     #puts countviewmoretwohundred,countviewmoretwohundred > 10
     #puts countviewmorethousand ,countviewmorethousand> 12
     #puts countlikemorethree ,countlikemorethree> 3
     #puts countlikemorefive ,countlikemorefive> 10
     #puts countlikemoreten,countlikemoreten > 12
     @sum_of_views=0
     all_users_view =REDIS.zrevrange "user/#{@user.id}/articles", 0, -1, withscores: true
     all_users_view.each do |view|
      @sum_of_views+=view.last.to_i
     end
     #puts @sum_of_views     
     @yesterday_article_published = REDIS.scard "user/#{@user.id}/articles/published/#{Date.yesterday.to_s}"
     #puts @yesterday_article_published

     #User.all.limit(50).each do |user|
     # puts "#{user.user_name}:#{user.week_views.first.day0}"   
     #end

     @nuarticleus = @user.articles.published.order("created_at desc").per_page_kaminari(params[:page])
    else
     @user = current_user
    end
  end

  def edit_articles
    @articleus = @user.articles.order("created_at desc").per_page_kaminari(params[:page])
    @title = "投稿編集"
    wv =  @user.week_views.first
    @weeks_views = [wv.day0,wv.day1,wv.day2,wv.day3,wv.day4,wv.day5,wv.day6]
    @charts = [[Date.today.advance(:days=>-7).strftime("%m/%d"),@weeks_views[6]],[Date.today.advance(:days=>-6).strftime("%m/%d"),@weeks_views[5]],[Date.today.advance(:days=>-5).strftime("%m/%d"),@weeks_views[4]],[Date.today.advance(:days=>-4).strftime("%m/%d"),@weeks_views[3]],[
Date.today.advance(:days=>-3).strftime("%m/%d"),@weeks_views[2]],[
Date.today.advance(:days=>-2).strftime("%m/%d"),@weeks_views[1]],[Date.yesterday.strftime("%m/%d"),@weeks_views[0]]]
    if @weeks_views.max != 0 && @weeks_views.min != 0
     
     maxviewdigits = Math.log10(@weeks_views.max).to_i #12345 5
     flotmaxview = @weeks_views.max * 0.1 ** maxviewdigits #1.2345
     @maxfloen = BigDecimal(flotmaxview.to_i+1).ceil * 10 ** maxviewdigits #2

     minviewdigits = Math.log10(@weeks_views.min).to_i #12345 5
     flotminview = @weeks_views.min * 0.1 ** minviewdigits #1.2345
     @minfloen = BigDecimal(flotminview.to_i+1).ceil * 10 ** minviewdigits #2
    else
     @maxfloen = 0
     @minfloen = 0
    end
    render layout: "user_page"
  end

  def twitter_auth_out
    SocialProfile.where(provider: "twitter").find_by(user_id: current_user.id).destroy!
    flash[:success] = "Twitter認証を解除しました"
    redirect_to :back
    #redirect_to user_path(current_user.name)
  end

  def facebook_auth_out
    SocialProfile.where(provider: "facebook").find_by(user_id: current_user.id).destroy!
    flash[:success] = "Facebook認証を解除しました"
    redirect_to :back 
  end

  def share_twitter
    
    current_user.update_attributes(:twitter_s => true)
    flash[:success] = "投稿公開時Twitterにてシェアされます"
    redirect_to :back
  end

  def inshare_twitter
    
    current_user.update_attributes(:twitter_s => false)
    flash[:success] = "投稿公開時Twitterにてシェアされなくなります"
    #redirect_to current_user
    redirect_to :back
  end

  def share_facebook
    current_user.update_attributes(:facebook_s => true)
    flash[:success] = "投稿公開時Facebookにてシェアされます"
    #redirect_to current_user
    redirect_to :back
    
  end

  def inshare_facebook
    current_user.update_attributes(:facebook_s => false)
    flash[:success] = "投稿公開時Facebookにてシェアされなくなります"
    #redirect_to current_user
    redirect_to :back
    
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
    @user = current_user 

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
  
  def verify_access_token
      user = User.find_by(id: params[:session][:id])
        if user
          #render text: "verified", status: 200
          render text: user.id, status: 200
        else
          render text: "Token failed verification", status: 422
        end
  end  
  
  private
  
    def set_user
      @user = User.find_by(name: params[:name])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password,:user_image,:header_image,:password_confirmation,:twitter_s,:facebook_s)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      redirect_to(user_path(@user)) unless @user == current_user
    end
    
    def admin_user?
      
      redirect_to(root_url) unless current_user.admin != false 
    end
    def certificate_user
      redirect_to root_url if current_user.certificated != false
    end
   
    
    def sort_column
      params[:q][:s]["0"][:name] || "name"
    end
  
    def sort_direction
     params[:q][:s]["0"][:dir] || "asc"
    end

    def sort_gteq
     params[:q][:created_at_gteq] || 0
    end

    def sort_lteq
     params[:q][:created_at_lteq] || 0
    end


  
end
