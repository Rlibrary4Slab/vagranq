class ArticlesController < AuthorizedController
#class ArticlesController < ApplicationController
  include Notifications
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :set_article, only: [ :show,:edit, :update,:destroy, :liking_users,:publish, :draft]
  before_action :correct_user,   only: [:edit, :update]
  before_action :correct_draft,   only: [:show]
  #before_action :twitter_share, only: [:create,:update]
  #before_action :facebook_share, only: [:create,:update]
  before_action :all
    def all
      @sitename = "RanQ"
      add_breadcrumb @sitename, root_path
      #ids = Like.group(:article_id).order('count(article_id) desc').pluck(:article_id).first(10)
      #@rank = Article.published.where(id: ids).order("field(id,#{ids.join(',')})").includes(:user) 
      @rank = Article.published.limit(10).order(view_count: :desc).includes(:user)
      #@toprank = Article.find(Like.group(:article_id).where('updated_at >= ?', 24.hour.ago).order('count(article_id) desc').limit(3).pluck(:article_id))
      @toprank = Article.where(:corporecom => [1..3]).published.limit(3)
      
      @corporecom = Article.where(:corporecom => [100..300]).published.limit(10).includes(:user)
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
    #@corporecom = Article.order("corporecom desc").published.per_page_kaminari(params[:page]).limit(10)
    #@articles = Article.page(params[:page]).per(3).published.get_by_title params[:title]
    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').order(created_at: :desc).limit(8).pluck(:article_id))

    #@toprank = Article.find(Like.group(:article_id).where('updated_at >= ?', 24.hour.ago).order('count(article_id) desc').limit(3).pluck(:article_id))
    #@toprank = Article.where(:corporecom => [1..3]).published.limit(3)

    #@articles = Article.order('updated_at desc').page(params[:page]).published
    @articles = Article.per_page_kaminari(params[:page]).published.order('updated_at desc').includes(:user)
  end
  
  def corporecom
    add_breadcrumb "おすすめ一覧", :allranking_path
    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(20).pluck(:article_id))
    @articles = Article.order("corporecom").order('updated_at >=? desc').published.page(params[:page])
  end

  def allranking
    add_breadcrumb "ランキング一覧", :allranking_path
    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(20).pluck(:article_id))
    @articles = Article.order("corporecom").published.per_page_kaminari(params[:page])
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
    @title = "ファッション一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ファッション一覧", :fashion_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.fashion params[:category] 
  end
  
  def beauty
    @title = "美容健康一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "美容健康一覧", :beauty_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.beauty params[:category]
    

  end
  def hangout
    @title = "おでかけ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "おでかけ一覧", :hangout_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.hangout params[:category]
    
  end
  def gourmet
    @title = "グルメ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "グルメ一覧", :gourmet_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.gourmet params[:category]
    
  end
  def lifestyle
    @title = "ライフスタイル一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ライフスタイル一覧", :lifestyle_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.lifestyle params[:category]
    
  end
  def entertainment
    @title = "エンタメ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "エンタメ一覧", :entertainment_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.entertainment params[:category]
    
  end
  def interior
    @title = "インテリア一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "インテリア一覧", :interior_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.interior params[:category]
    
  end
  def gadget
    @title = "ガジェット一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ガジェット一覧", :gadget_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.gadget params[:category]
    
  end
  def learn
    @title = "学び一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "学び一覧", :learn_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.learn params[:category]
    
  end
  def funny
    @title = "おもしろ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "おもしろ一覧", :funny_path
    @articles = Article.per_page_kaminari(params[:page]).published.includes(:user)
    @articles = @articles.funny params[:category]
    
  end
  #categoriesend
  
  def rank
  
  end
  
  def liking_users
    add_breadcrumb "いいねしたユーザー"
    @users = @article.liking_users
  end
  # GET /articles/1
  # GET /articles/1.json
  def show
    
    if @article.category == "ファッション"
      add_breadcrumb @article.category, fashion_path
    end
    if @article.category == "美容健康"
      add_breadcrumb @article.category, beauty_path
    end
    if @article.category == "おでかけ"
      add_breadcrumb @article.category, hangout_path
    end
    if @article.category == "グルメ"
      add_breadcrumb @article.category, gourmet_path
    end
    if @article.category == "ライフスタイル"
      add_breadcrumb @article.category, lifestyle_path
    end
    if @article.category == "エンタメ"
      add_breadcrumb @article.category, entertainment_path
    end
    if @article.category == "インテリア"
      add_breadcrumb @article.category, interior_path
    end
    if @article.category == "ガジェット"
      add_breadcrumb @article.category, gadget_path
    end
    if @article.category == "学び"
      add_breadcrumb @article.category, learn_path
    end
    if @article.category == "おもしろ"
      add_breadcrumb @article.category, funny_path
    end
    @likes = Like.where(article_id: params[:id])
    add_breadcrumb @article.title
    #@more_like_this = Article.find(@article.more_like_this.results.map(&:id)) 
    #@more_like_this = Article.where(:id => @article.more_like_this.results.map(&:id)).per_page_kaminari(params[:page]).published 
    #@more_like_this = Article.where(:id => @article.more_like_this.results.map(&:id)).per_page_kaminari(params[:page]) 
    ids = @article.more_like_this.results.map(&:id)
    @idsemptybool = ids.empty?
    @more_like_this = Article.published.where(:id => ids).order("field(id, #{ids.join(',')})").per_page_kaminari(params[:page]) 
    REDIS.zincrby "user/#{@article.user_id}/articles/daily/#{Date.today.to_s}", 1, "#{@article.id}"
    REDIS.zincrby "user/#{@article.user_id}/articles", 1, "#{@article.id}"
    @page_views_get = REDIS.zscore "user/#{@article.user_id}/articles/daily/#{Date.today.to_s}","#{@article.id}"
    @page_views_get_all = REDIS.zscore "user/#{@article.user_id}/articles","#{@article.id}"
    @page_views = @page_views_get_all.to_i 
    
    @article.update_columns(view_count: @page_views)
    sum_of_imp = Article.where(user_id: @article.user_id).sum(:view_count)
   
    if @page_views <= 1000              #記事単体view数
      puts @article.title
      puts @page_views
      if @page_views % 100 == 0
      # if @page_views % 1 == 0
        notification_savesend(@article, @page_views, 4, @article.eyecatch_img)
      end
    else
      #if @page_views % 2 == 0
      if @page_views % 2000 == 0
        notification_savesend(@article, @page_views, 4, @article.eyecatch_img)
      end
    end
    if sum_of_imp % 1000 == 0            #総view数
    #if sum_of_imp % 1 == 0            #総view数
    notification_savesend(@article, sum_of_imp, 5, current_user.user_image_url(:thumb))
    end
    
  end

  # GET /articles/new
  def new
    @article = Article.new
    2.times {@article.contents.build}
    render layout: 'article_new'
  end

  # GET /articles/1/edit
  def edit
    render layout: 'article_new'
  end

  # POST /articles
  # POST /articles.json
  #def create
  #  @article = current_user.articles.build(article_params)
  #
  #  respond_to do |format|
  #    if @article.save
  #      format.html { redirect_to @article, notice: 'Article was successfully created.' }
  #      format.json { render :show, status: :created, location: @article }
  #    else
  #      format.html { render :new }
  #      format.json { render json: @article.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  
  #def update
  #  respond_to do |format|
  #    if @article.update(article_params)
  #      format.html { redirect_to @article, notice: 'Article was successfully updated.' }
  #      format.json { render :show, status: :ok, location: @article }
  #    else
  #      format.html { render :edit }
  #      format.json { render json: @article.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end
  
  def create
    @article = current_user.articles.build(article_params)
    
    if @article.description != "" 
      drion = ActionController::Base.helpers.strip_tags(@article.description.to_s).strip!.gsub(/[\r\n]/,"").truncate(124, omission: '')
    else
      drion = ActionController::Base.helpers.strip_tags(@article.description.to_s).truncate(124, omission: '')
    end
    
    if @article.valid?
      
      @article.save!
      case params[:ope][:cmd]
      when 'publish'
        @article.publish!
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
      redirect_to @article
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

    @article.assign_attributes(article_params)
    if @article.description != "" 
      drion = ActionController::Base.helpers.strip_tags(@article.description.to_s).strip!.gsub(/[\r\n]/,"").truncate(124, omission: '')
    else
      drion = ActionController::Base.helpers.strip_tags(@article.description.to_s).truncate(124, omission: '')
    end
    

    if @article.valid?
      @article.save!
      case params[:ope][:cmd]
      when 'publish'
        @article.publish!
        flash[:success] = '記事を公開しました。'
        if @article.published_at.nil? != true 
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
        end 
      when 'draft'
        @article.draft!
        flash[:success] = '記事を下書きにしました。'
      when 'save'
        flash[:success] = '記事を更新しました。'
      else
        raise
      end
      
      #redirect_to [:home, @article]
      redirect_to @article
    else
     render :edit
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
      @article = Article.find(params[:id])
      #@article = current_user.articles.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:category, :title, :description, :user_id,:aasm_state,:eyecatch_img,:checkagree,contents_attributes: [:id,:title,:description,:_destroy,:position])
    end
    
    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
    
    def correct_draft
      @articlep = Article.published.find_by(id: params[:id])
      @article = Article.find_by(id: params[:id])
      redirect_to root_url if @articlep.nil? && current_user.name != @article.user.name 
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
end
