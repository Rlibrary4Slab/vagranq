class ItemsController < AuthorizedController
#class ArticlesController < ApplicationController
  include Notifications
  before_action :combine_item?, only: [:show]
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :set_item, only: [ :show,:edit, :update,:destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :correct_draft,   only: [:show]
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
    
  # GET /articles
  # GET /articles.json
  def index
    @Items = Item.per_page_kaminari(params[:page]).order('updated_at desc').includes(:user)
  end
  

  
  def show
    
  end

  def new
    @item = Item.new
    render layout: 'article_new'
  end

  def edit
    render layout: 'article_new'
  end

  
  def create
    @item = current_user.items.build(item_params)
    
    
    if @item.valid?
      
      @item.save!
      flash[:success] = '[編集対象]を保存しました。'
      #redirect_to [:home, @article]
      redirect_to @item
    else
      render :new, layout: 'article_new'
    end
  end

  def update

    @item.assign_attributes(item_params)
    if @item.valid?
      @item.save!
      flash[:success] = '[編集箇所]を更新しました'
      
      #redirect_to [:home, @article]
      redirect_to @item
    else
     render :edit
    end
  end
  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      #format.html { redirect_to itemss_url, notice: 'Article was successfully destroyed.' }
      format.html { redirect_to :back, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end
  
  private
    def combine_item?
      @item = Item.find(params[:id])
      afterItem = @item.combine 
      puts afterItem 
      if !afterItem.nil? 
       @itemAfter = Item.find(@item.combine)
       redirect_to @itemAfter 
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :description, :user_id,:price,:date,:eyecatch_img,:combine,:address)
    end
    
    def correct_user
      @item = current_user.items.find_by(id: params[:id])
      redirect_to root_url if @item.nil?
    end
    
    def correct_draft
      @itemp = Item.find_by(id: params[:id])
      @item = Item.find_by(id: params[:id])
      redirect_to root_url if @itemp.nil? && current_user.name != @item.user.name 
    end
   
end
