class ItemsController < AuthorizedController
  include Notifications
  
  before_action :combine_item?, only: [:show]
  before_action :authenticate_user!, only: [:new,:edit]
  before_action :set_item, only: [ :show,:edit, :update,:destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_item_tags_to_gon,   only: [:edit, :update]
  before_action :set_available_tags_to_gon,   only: [:new,:edit]
  before_action :correct_draft,   only: [:show]
  before_action :all
  def all
      add_breadcrumb "RanQ", root_path
      @rank = Article.published.limit(10).order(view_count: :desc).includes(:user)
      @corporecom = Article.where(:corporecom => [100..300]).published.limit(10).includes(:user)
  end
    
  # GET /articles
  # GET /articles.json
  def index
    @Items = Item.per_page_kaminari(params[:page]).order('updated_at desc').includes(:user)
  end
  

  
  def show
    puts @item.title
    respond_to do |format|
      format.html
      format.json {render :json => @item}
      format.xml  {render :xml => @item}
    end
    
  end

  def new
    @item = Item.new
    @item.item_days.build
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
      redirect_to @item
    else
      render :new, layout: 'article_new'
    end
  end

  def update
    puts Item.find(39).item_spots.empty?
    puts Item.find(39).title

    @item.assign_attributes(item_params)
    if @item.valid?
      if @item.category == "イベント"
        spot_id = Item.find_by(title: @item.tag_list.first).id 
        if !@item.item_spots.empty? #アイテムがスポットを保持しているばあい通す
          ItemSpot.find_by(item_id: @item.id).update_attributes(spot_id: spot_id)
        else
          item_spot = @item.item_spots.build(item_id: @item.id,spot_id: spot_id ) 
          item_spot.save! 
        end
      end
      @item.update_attributes(address: Item.find_by(title: @item.tag_list.first).address)
      @item.save!
      flash[:success] = '[編集箇所]を更新しました'
      
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
      params.require(:item).permit(:title, :description, :user_id,:price,:date,:eyecatch_img,:combine,:address,:image,:category,:tag_list,:phonenumber,:remark,item_days_attributes: [:id, :mon,:tue ,:wed,:thu,:fri,:sat,:sun,:hol,:begin_time, :finish_time, :begin_day,:finish_day,:_destroy])
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
    def set_item_tags_to_gon
     gon.item_tags = @item.tag_list
    end
    def set_available_tags_to_gon
     gon.available_tags = Item.where(category: 20).pluck(:title)
    end
   
end
