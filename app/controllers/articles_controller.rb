class ArticlesController < AuthorizedController
#class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :set_article, only: [ :show,:edit, :update,:destroy, :liking_users,:publish, :draft]
  before_action :correct_user,   only: [:edit, :update]
  before_action :correct_draft,   only: [:show]
  impressionist actions: [:show]
  before_action :all
  add_breadcrumb "RanQ", :root_path
    def all
      ids = Like.group(:article_id).order('count(article_id) desc').pluck(:article_id)
      @rank = Article.published.where(id: ids).order("field(id,#{ids.join(',')})") 

      #@toprank = Article.find(Like.group(:article_id).where('updated_at >= ?', 24.hour.ago).order('count(article_id) desc').limit(3).pluck(:article_id))
      @toprank = Article.where(:corporecom => [1..3]).published.limit(3)

      @corporecom = Article.where(:corporecom => [100..300]).published.limit(10)
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
    #@articles = Atricle.search(params[:search])
    #@articles = Article.all
    #@corporecom = Article.order("corporecom desc").published.per_page_kaminari(params[:page]).limit(10)
    #@articles = Article.page(params[:page]).per(3).published.get_by_title params[:title]
    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').order(created_at: :desc).limit(8).pluck(:article_id))

    #@toprank = Article.find(Like.group(:article_id).where('updated_at >= ?', 24.hour.ago).order('count(article_id) desc').limit(3).pluck(:article_id))
    #@toprank = Article.where(:corporecom => [1..3]).published.limit(3)

    #@articles = Article.order('updated_at desc').page(params[:page]).published
    @articles = Article.per_page_kaminari(params[:page]).published.order('updated_at desc')
    #@q        = Article.ransack(params[:q])
    #@qarticles = @q.result(distinct: true)
  end
  
  def corporecom
    add_breadcrumb "おすすめ一覧", :allranking_path
    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(20).pluck(:article_id))
    @articles = Article.order("corporecom").order('updated_at >=? desc').published.page(params[:page])
  end

  def allranking
    add_breadcrumb "ランキング一覧", :allranking_path
    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(20).pluck(:article_id))
    @articles = Article.order("corporecom").published.page(params[:page])
    #@articles = 
  end
  #categories
  def fashion
    @title = "ファッション一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ファッション一覧", :fashion_path
    @articles = Article.per_page_kaminari(params[:page]).published
    @articles = @articles.fashion params[:category] 
  end
  
  def beauty
    @title = "美容健康一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "美容健康一覧", :beauty_path
    @articles = Article.per_page_kaminari(params[:page]).published 
    @articles = @articles.beauty params[:category]
    

  end
  def hangout
    @title = "おでかけ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "おでかけ一覧", :hangout_path
    @articles = Article.per_page_kaminari(params[:page]).published 
    @articles = @articles.hangout params[:category]
    
  end
  def gourmet
    @title = "グルメ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "グルメ一覧", :gourmet_path
    @articles = Article.per_page_kaminari(params[:page]).published 
    @articles = @articles.gourmet params[:category]
    
  end
  def lifestyle
    @title = "ライフスタイル一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ライフスタイル一覧", :lifestyle_path
    @articles = Article.per_page_kaminari(params[:page]).published 
    @articles = @articles.lifestyle params[:category]
    
  end
  def entertainment
    @title = "エンタメ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "エンタメ一覧", :entertainment_path
    @articles = Article.per_page_kaminari(params[:page]).published 
    @articles = @articles.entertainment params[:category]
    
  end
  def interior
    @title = "インテリア一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "インテリア一覧", :interior_path
    @articles = Article.per_page_kaminari(params[:page]).published 
    @articles = @articles.interior params[:category]
    
  end
  def gadget
    @title = "ガジェット一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ガジェット一覧", :gadget_path
    @articles = Article.per_page_kaminari(params[:page]).published 
    @articles = @articles.gadget params[:category]
    
  end
  def learn
    @title = "学び一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "学び一覧", :learn_path
    @articles = Article.per_page_kaminari(params[:page]).published 
    @articles = @articles.learn params[:category]
    
  end
  def funny
    @title = "おもしろ一覧"
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "おもしろ一覧", :funny_path
    @articles = Article.per_page_kaminari(params[:page]).published 
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
    #add_breadcrumb @article.category
    add_breadcrumb @article.title
    
    impressionist(@article, nil) #1時間起きに増やす
    @page_views = @article.impressionist_count
  end

  # GET /articles/new
  def new
    @article = Article.new
    2.times {@article.contents.build}
  end

  # GET /articles/1/edit
  def edit
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
    #@article.body = RedcarpetCompiler.compile(@article.body_source)

    if @article.valid?
      @article.save!
      case params[:ope][:cmd]
      when 'publish'
        @article.publish!
        flash[:success] = '記事を公開しました。'
      when 'save'
        flash[:success] = '記事を保存しました。'
      else
        raise
        #render :new
      end
      #redirect_to [:home, @article]
      #render :new
      redirect_to @article
    else
      render :new
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

    if @article.valid?
      #@article.body = RedcarpetCompiler.compile(@article.body_source)
      @article.save!
      case params[:ope][:cmd]
      when 'publish'
        @article.publish!
        flash[:success] = '記事を公開しました。'
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
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
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
      #params.require(:ssquire).permit(:aasm_state,contents_attributes: [:id,:title,:description,:_destroy])
    end
    
    def correct_user
      #@user = User.find(params[:id])
    #  @user = User.find_by(name: params[:name])
    #  redirect_to(root_url) unless @user == current_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
    
    def correct_draft
      @articlep = Article.published.find_by(id: params[:id])
      @article = Article.find_by(id: params[:id])
      redirect_to root_url if @articlep.nil? && current_user.name != @article.user.name 
    end
    
end
