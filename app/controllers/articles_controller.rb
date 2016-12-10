class ArticlesController < AuthorizedController
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :set_article, only: [ :show,:edit, :update,:destroy, :liking_users,:publish, :draft]
  before_action :correct_user,   only: [:edit, :update]
  impressionist actions: [:show]
  before_action :pvranking
  add_breadcrumb "RanQ", :root_path
  
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
    @articles = Article.page(params[:page]).per(3).published.get_by_title params[:title]
    #@q        = Article.ransack(params[:q])
    #@qarticles = @q.result(distinct: true)
  end
  
  def allranking
    @rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(20).pluck(:article_id)) 
  end
  #categories
  
  def cfashion
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ファッション一覧", :cfashion_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  
  def cbeauty
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ビューティ一覧", :cbeauty_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  def clifestyle
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "ライフスタイル一覧", :clifestyle_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  def cgourmet
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "グルメ一覧", :cgourmet_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  def changout
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "おでかけ一覧", :changout_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  def centertainment
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "エンタメ一覧", :centertainment_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  def cstudy
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "学び一覧", :cstudy_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  def cbusiness
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "アイテム一覧", :citem_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  def cfunny
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "おもしろ一覧", :cfunny_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
  end
  def cothers
    add_breadcrumb "記事一覧", :articles_path
    add_breadcrumb "その他一覧", :cothers_path
    @articles = Article.page(params[:page]).per(3).published 
    @articles = @articles.get_by_category params[:category]
    
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
      add_breadcrumb @article.category, cfashion_path(category: 20)
    end
    if @article.category == "ビューティー"
      add_breadcrumb @article.category, cbeauty_path(category: 30)
    end
    if @article.category == "ライフスタイル"
      add_breadcrumb @article.category, clifestyle_path(category: 40)
    end
    if @article.category == "グルメ"
      add_breadcrumb @article.category, cgourmet_path(category: 50)
    end
    if @article.category == "おでかけ"
      add_breadcrumb @article.category, changout_path(category: 60)
    end
    if @article.category == "エンタメ"
      add_breadcrumb @article.category, centertainment_path(category: 70)
    end
    if @article.category == "学び"
      add_breadcrumb @article.category, cstudy_path(category: 80)
    end
    if @article.category == "アイテム"
      add_breadcrumb @article.category, citem_path(category: 90)
    end
    if @article.category == "おもしろ"
      add_breadcrumb @article.category, cfunny_path(category: 100)
    end
    if @article.category == "その他"
      add_breadcrumb @article.category, cothers_path(category: 110)
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
      end
      #redirect_to [:home, @article]
      #render :edi
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
      params.require(:article).permit(:category, :title, :description, :user_id,:aasm_state,:eyecatch_img,
                                      contents_attributes: [:id,:title,:description,:_destroy,:position])
      #params.require(:ssquire).permit(:aasm_state,contents_attributes: [:id,:title,:description,:_destroy])
    end
    
    def correct_user
      #@user = User.find(params[:id])
    #  @user = User.find_by(name: params[:name])
    #  redirect_to(root_url) unless @user == current_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to root_url if @article.nil?
    end
    
end
