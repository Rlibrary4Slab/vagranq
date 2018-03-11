class ArticlesController < AuthorizedController
  include Notifications
  #before_action :load_paper,  only: [:index]
  before_action :set_article, only: [ :show ,:liking_users,:article_inquiry,:edit, :update,:destroy,:publish, :draft]
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :correct_user,   only: [:edit, :update]
  before_action :correct_draft,   only: [:show]
  before_action :exclusion_user
  before_action :set_like_items_to_gon , only: [:show]
  before_action :siderank, except: [:show]
  before_action :allshow, only: [:show]
    def siderank 
      add_breadcrumb "RanQ", root_path
       
       @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user) unless read_fragment "articles/page#{params[:page]}"
       #@corporecom ||= Rails.cache.fetch("corp1", expires_in: 10.seconds) do
         @corporecom =Article.where(:corporecom => [100..300]).published.limit(10).includes(:user)  unless read_fragment "articles/page#{params[:page]}"
       #end 
       
    end
    def allshow
      add_breadcrumb "RanQ", root_path
    end
    
    def pvranking
      require 'google_api'
      api = GoogleApi.new
      api.authorize!
      analytics = api.get_pvranking(max_results: 10)
      @ranking  = JSON.parse(analytics.response.body)["rows"]
    end
  # GET /articles
  # GET /articles.json
  def index
    add_breadcrumb "記事一覧", :articles_path
   # @data = load_paper.per_page_kaminari(params[:page])
    @articles = Article.per_page_kaminari(params[:page]).where("(aasm_state =? ) OR (aasm_state=?)", "published","news").order('updated_at desc').includes(:user) unless read_fragment "articles/page#{params[:page]}" 
  end
 
  def article_inquiry
    
    @inquiry = Inquiry.new(article_id: params[:id],article_title: @article.title)
  end 
  
  def corporecom
    add_breadcrumb "おすすめ一覧", :allranking_path
    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(20).pluck(:article_id))
    @articles = Article.order("corporecom").order('updated_at >=? desc').published.includes(:user).page(params[:page]) unless read_fragment "pusher"
  end

  def allranking
    add_breadcrumb "ランキング一覧", :allranking_path
    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(20).pluck(:article_id))
    @articles = Article.published.limit(10).per_page_kaminari(params[:page]).order(view_count: :desc).includes(:user)
    #@articles = Article.order("corporecom").published.per_page_kaminari(params[:page])
    #@articles = 
  end

  def search
    @title = "検索結果一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "検索結果一覧", :search_path
    @articles = if params[:q] != ""
		  Article.search(params[:q]).records.published.per_page_kaminari(params[:page])
		  #Article.search(params).records
		else
		  Article.per_page_kaminari(params[:page]).published.order("updated_at desc")
		end
  end
  
  #categories
  def fashion
    @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).fashion params[:category] #unless read_fragment "articles/page#{params[:page]}"
    @title = "ファッション一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ファッション一覧", :fashion_path
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user).fashion params[:category] 
  end
  
  def beauty
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).beauty params[:category] #unless read_fragment "articles/page#{params[:page]}"
    @title = "美容健康一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "美容健康一覧", :beauty_path
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user).beauty params[:category]
    

  end
  def hangout
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).hangout params[:category]
    @title = "おでかけ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "おでかけ一覧", :hangout_path
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user).hangout params[:category]
    
  end
  def gourmet
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).gourmet params[:category]
    @title = "グルメ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "グルメ一覧", :gourmet_path
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user).gourmet params[:category]
    
  end
  def lifestyle
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).lifestyle params[:category]
    @title = "ライフスタイル一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ライフスタイル一覧", :lifestyle_path
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user).lifestyle params[:category]
    
  end
  def entertainment
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).entertainment params[:category]
    @title = "エンタメ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "エンタメ一覧", :entertainment_path
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user).entertainment params[:category]
    
  end
  def interior
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).interior params[:category]
    @title = "インテリア一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "インテリア一覧", :interior_path
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user).interior params[:category]
    
  end
  def gadget
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).gadget params[:category]
    @title = "ガジェット一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ガジェット一覧", :gadget_path
    @articles = Article.per_page_kaminari(params[:page]).order("updated_at desc").published.includes(:user).gadget params[:category]
    
  end
  def learn
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).learn params[:category]
    @title = "学び一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "学び一覧", :learn_path
    @articles = Article.per_page_kaminari(params[:page]).order("updated_at desc").published.includes(:user).learn params[:category]
    
  end
  def funny
     @rank=  Article.published.limit(10).order(view_count: :desc).includes(:user).funny params[:category]
    @title = "おもしろ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "おもしろ一覧", :funny_path
    @articles = Article.per_page_kaminari(params[:page]).order("updated_at desc").published.includes(:user).funny params[:category]
    
  end
  #categoriesend
  
  def rank
  
  end
  
  def liking_users
    add_breadcrumb "いいねしたユーザー"
    @users = @article.liking_users
    puts @article.liking_users.count
  end
  # GET /articles/1
  # GET /articles/1.json
  def show
      @articles =unless params[:pande].blank?

         Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user) 
      else 
        @article 
      end
      respond_to {|format|  format.html  format.js } unless params[:pande].blank?
   
    unless read_fragment "#{@user_discrime}/articles/#{@article.updated_at.strftime('%Y%m%d%H%M%S')}" 
     add_breadcrumb @article.category, fashion_path if @article.category == "ファッション"
     redis_category = "fashion" if @article.category == "ファッション"
     add_breadcrumb @article.category, beauty_path if @article.category == "美容健康"
     redis_category = "beauty" if @article.category == "美容健康"
     add_breadcrumb @article.category, hangout_path if @article.category == "おでかけ"
     redis_category = "hangout" if @article.category == "おでかけ"
     add_breadcrumb @article.category, gourmet_path if @article.category == "グルメ"
     redis_category = "gourmet" if @article.category == "グルメ"
     add_breadcrumb @article.category, lifestyle_path if @article.category == "ライフスタイル"
     redis_category = "lifestyle" if @article.category == "ライフスタイル"
     add_breadcrumb @article.category, entertainment_path if @article.category == "エンタメ"
     redis_category = "entertainment" if @article.category == "エンタメ"
     add_breadcrumb @article.category, interior_path if @article.category == "インテリア"
     redis_category = "interior" if @article.category == "インテリア"
     add_breadcrumb @article.category, gadget_path if @article.category == "ガジェット"
     redis_category = "gadget" if @article.category == "ガジェット"
     add_breadcrumb @article.category, learn_path if @article.category == "学び"
     redis_category = "learn" if @article.category == "学び"
     add_breadcrumb @article.category, funny_path if @article.category == "おもしろ"
     redis_category = "funny" if @article.category == "おもしろ"
     add_breadcrumb @article.title
     ids = REDIS.lrange "articles/#{@article.id}/morelikethis",0,-1
     @idsemptybool = ids.empty?
     @more_like_this = Article.published.where(:id => ids).order("field(id, #{ids.join(',')})").per_page_kaminari(params[:page]) #if params[:page].blank? 
    end
    if  !@article.draft?  && params[:page].blank? #&& User.find_by(id: @article.user_id).certificated != true  
      REDIS.zincrby "articles/category/#{redis_category}/daily/#{Date.today.to_s}", 1, "#{@article.id}"
      REDIS.zincrby "articles/category/#{redis_category}", 1, "#{@article.id}"
      REDIS.zincrby "articles_ranking/daily/#{Date.today.to_s}", 1, "#{@article.id}"
      REDIS.zincrby "articles_ranking/daily/#{Date.today.to_s}/#{Time.now.to_time.strftime("%H00").to_s}", 1, "#{@article.id}"
      REDIS.zincrby "articles_ranking", 1, "#{@article.id}"
      REDIS.zincrby "user/#{@article.user_id}/articles/daily/#{Date.today.to_s}", 1, "#{@article.id}"
      REDIS.zincrby "user/#{@article.user_id}/articles", 1, "#{@article.id}"
    end 
	    @page_views_get_all = REDIS.zscore "user/#{@article.user_id}/articles","#{@article.id}"
	    @page_views = @page_views_get_all.to_i 
	    @article.update_column(:view_count, @page_views)
	    sum_of_imp=0
	    all_users_view =REDIS.zrevrange "user/#{@article.user_id}/articles", 0, -1, withscores: true
	    all_users_view.each { |view|   sum_of_imp+=view.last.to_i }
	    
    #sum_of_imp = Article.where(user_id: @article.user_id).sum(:view_count)
    #記事を書いたユーザーの総投稿の総View数取得 もっと早くできる
    
	    live_counter_view   


	    if @page_views <= 1000              #記事単体view数
	      notification_savesend(@article, @page_views, 4, @article.eyecatch_img) if @page_views % 100 == 0 && @page_views !=0
	    else
	      notification_savesend(@article, @page_views, 4, @article.eyecatch_img) if @page_views % 2000 == 0 && @page_views !=0
	    end
	    notification_savesend(@article, sum_of_imp, 5, current_user.user_image_url(:thumb)) if sum_of_imp % 1000 == 0 
	    respond_to { |format|
	       format.html
	       format.js
	       format.json {render :json => @article}
	       format.xml  {render :xml => @article}
            }
  end

  # GET /articles/new
  def new
    @article = if params[:neid] 
             nc = NewsCrawler.find(params[:neid])  
             Article.new(title: nc.title, description: nc.news_image+nc.news_body,neid: params[:neid])
             else 
               Article.new
             end
    2.times {@article.contents.build}
    render layout: 'article_new'
  end

  # GET /articles/1/edit
  def edit
    @article= Article.find(params[:id])
    render layout: 'article_new'
  end

  
  def create
    @article = current_user.articles.build(article_params)
    
    if @article.description != "" 
      drion = ActionController::Base.helpers.strip_tags(@article.description.to_s).strip!.gsub(/[\r\n]/,"").truncate(124, omission: '')
    else
      drion = ActionController::Base.helpers.strip_tags(@article.description.to_s).truncate(124, omission: '')
    end
    
    if @article.valid?
      current_user.update_attributes(count_articles: current_user.articles.count)
      @article.attributes= {likes_count: 0} 
      @article.save!
      ids = @article.more_like_this.results.map(&:id)
      REDIS.del "articles/#{@article.id}/morelikethis"
      if ids.empty? != true
       REDIS.lpush "articles/#{@article.id}/morelikethis", ids
      end
     
      case params[:ope][:cmd]
      when 'publish'
        @article.publish!
        REDIS.sadd "user/#{@article.user_id}/articles/published/#{Date.today.to_s}", "#{@article.id}"
        flash[:success] = '記事を公開しました。'
        
        if current_user.twitter_s != false && current_user.social_profiles.where(provider: "twitter").empty? != true
          twitter_share.update("『#{@article.title}』をRanQで書きました\nranq-media.com/articles/#{@article.id}")
        end
        if current_user.facebook_s != false && current_user.social_profiles.where(provider: "facebook").empty? != true
          facebook_share.feed!(
           :message => "『#{@article.title}』をRanQで書きました\n",
           #:picture => 'https://graph.facebook.com/matake/picture',
           :link => "ranq-media.com/articles/#{@article.id}",
           #:link => "ranq-media.com/articles/351",
           :name => "#{@article.title}",
           :description => "#{drion}"
          )
        end 
      when 'save'
        flash[:success] = '記事を保存しました。'
      else
        raise
      end
      #redirect_to [:home, @article]
      if !@article.neid.empty? 
       NewsCrawler.find(@article.neid).update_column(:article_id, @article.id)
       redirect_to new_news_tag_path(title: @article.title,link: @article.id)
      else
       redirect_to @article
      end
    else
      render :new, layout: 'article_new'
    end
  end

  def publish
    @article.publish!
    flash[:success] = '記事を公開しました。'
    #redirect_to [:home, @article]
    redirect_to @article
  end

  def draft
    @article.draft!
    flash[:success] = '記事を下書きにしました。'
    #redirect_to [:home, @article]
    redirect_to @article
  end


  # PATCH/PUT /articles/1
  def update
      Rails.cache.delete("views/#{@user_discrime}/articles/#{@article.updated_at.strftime('%Y%m%d%H%M%S')}")      

    @article.assign_attributes(article_params)
    if @article.description != "" 
      drion = ActionController::Base.helpers.strip_tags(@article.description.to_s).strip!.gsub(/[\r\n]/,"").truncate(124, omission: '')
    else
      drion = ActionController::Base.helpers.strip_tags(@article.description.to_s).truncate(124, omission: '')
    end
    

    if @article.valid?
      current_user.update_attributes(count_articles: current_user.articles.count)
      Rails.cache.delete("page/article/#{params[:id]}")      
      @article.updated_at = Time.now
      ids = @article.more_like_this.results.map(&:id)
      REDIS.del "articles/#{@article.id}/morelikethis"
      if ids.empty? != true 
      REDIS.lpush "articles/#{@article.id}/morelikethis", ids 
      end
      case params[:ope][:cmd]
      when 'publish'
        Rails.cache.delete("page/article/#{params[:id]}")      
        @article.publish!
        if @article.published_at.nil? != true 
         @article.published_at = Time.now
         @article.save!
         REDIS.sadd "user/#{@article.user_id}/articles/published/#{Date.today.to_s}", "#{@article.id}"
         if current_user.twitter_s != false && current_user.social_profiles.where(provider: "twitter").empty? != true 
          twitter_share.update("『#{@article.title}』をRanQで書きました\nranq-media.com/articles/#{@article.id}")
         end
  
         if current_user.facebook_s != false && current_user.social_profiles.where(provider: "facebook").empty? != true
          facebook_share.feed!(
           :message => "『#{@article.title}』をRanQで書きました\n",
           :link => "ranq-media.com/articles/#{@article.id}",
           :name => "#{@article.title}",
           :description => "#{drion}"
          )
         end
        end 
       flash[:success] = '記事を公開しました。'
      when 'draft'
        @article.save!
        @article.draft!
        flash[:success] = '記事を下書きにしました。'
      when 'save'
        @article.save!
        flash[:success] = '記事を更新しました。'
      else
        raise
      end
      
      #redirect_to [:home, @article]
      redirect_to @article
    else
     render :edit, layout: 'article_new'
    end
  end
  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      #format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.html { redirect_to :back, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @user_discrime = logged_in? ? current_user.id : "nonuser" 
      #@article ||= Rails.cache.fetch("article/#{params[:id]}") do
       @article=  Article.find(params[:id])  
      #end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:category, :title, :description, :user_id,:aasm_state,:eyecatch_img,:checkagree,:neid,contents_attributes: [:id,:title,:description,:_destroy,:position])
    end
    
    def correct_user
      #unless read_fragment "#{@user_discrime}/articles/#{@article.updated_at.strftime('%Y%m%d%H%M%S')}"
       article = current_user.articles.find_by(id: params[:id])
       redirect_to root_url if current_user.admin != true && article.nil?
      #end
    end
    def exclusion_user
        redirect_to root_url if logged_in? && current_user.exclusion 
    end
    
    def correct_draft
      #unless read_fragment "#{@user_discrime}/articles/#{@article.updated_at.strftime('%Y%m%d%H%M%S')}"
      if logged_in?
       redirect_to root_url if @article.draft? && current_user.name != @article.user.name 
      else 
       redirect_to root_url if @article.draft? 
       
      end 
      #end 
    end
   
    def twitter_share
     result = JSON.parse(current_user.social_profiles.where(provider: "twitter").map(&:credentials).first)  
     client = Twitter::REST::Client.new do |config|
      # developer
      config.consumer_key         = OAUTH_CONFIG[:twitter]['key'] 
      config.consumer_secret      = OAUTH_CONFIG[:twitter]['secret']
      # user
      config.access_token         = result["token"].to_s
      config.access_token_secret  = result["secret"].to_s
     end
     return client
    end

    def facebook_share
     result = JSON.parse(current_user.social_profiles.where(provider: "facebook").map(&:credentials).first)
     #graph = Koala::Facebook::API.new(result["token"].to_s)
     graph = FbGraph::User.me(result["token"].to_s)
     return graph
    end
    
    def set_like_items_to_gon
     gon.logged_in = logged_in?
     if logged_in?
      gon.like_items = current_user.item_likes.where(:article_id => params[:id])
     end
    end

    def cache_key(type = nil)
      [
       self.class.name.underscore,
       type
      ].join('')
    end
end
