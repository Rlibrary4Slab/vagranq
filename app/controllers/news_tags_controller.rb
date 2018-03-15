class NewsTagsController < ApplicationController 
  require 'rss'
  before_action :set_news_tag, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:index,:new,:edit]
   

  # GET /news_tags
  # GET /news_tags.json
  def index
    @news_tags = NewsTag.where("created_at > ?",24.hours.ago).order("created_at desc").limit(7)
    @crawlingnews = NewsCrawler.order("created_at desc").all
    
  end
 
  def postfromgas
   for item in params["items"]
    #puts item[0] #title
    #puts item[1] #pageurl
    #puts item[2] #body
    #puts item[3] #image
    #puts item[4] #maketime
    #puts item[5] #picktime
    #puts item[6] #rssurl
     newsCrawler = NewsCrawler.new(title: item[0],news_link: item[1],news_body: item[2],news_image: item[3])
     newsCrawler.save
   end
   render json: "success"
  end

  # GET /news_tags/1
  # GET /news_tags/1.json
  def show
   redirect_to article_path(@news_tag.link)
  end

  # GET /news_tags/new
  def new
    @news_tag =  if params[:link]
             NewsTag.new(title:params[:title],link: params[:link]) 
             else
             NewsTag.new
             end
    @news_tags = NewsTag.where("created_at > ?",24.hours.ago).order("created_at desc")
  end

  # GET /news_tags/1/edit
  def edit
  end

  # POST /news_tags
  # POST /news_tags.json
  def create
    @news_tags = NewsTag.where("created_at > ?",24.hours.ago).order("created_at desc").limit(7)
    @news_tag = NewsTag.new(news_tag_params)
    article = Article.find_by_id(@news_tag.link)

      respond_to do |format|
        if !article.nil?
          if NewsTag.where(title: @news_tag.title).where("created_at > ?",1.days.ago).count < 1
            @news_tag.attributes = {article_title: article.title,article_description: article.description}
            if @news_tag.save

              Article.find(@news_tag.link).to_news!
              
              twitter_share.update("#{article.title}\nranq-media.com/articles/#{article.id}") if Rails.env.production?

              format.html { redirect_to article_path(@news_tag.link), notice: 'News tag was successfully created.' }
              format.json { render :show, status: :created, location: @news_tag }
            else
              puts @news_tag.errors
              format.html { render :new }
              format.json { render json: @news_tag.errors, status: :unprocessable_entity }
            end
          else
           flash[:error] = "1日に同一のタイトルはつけられません"
           format.html { render :new }
          end
        else
           flash[:error] = "正しい投稿IDを入力してください"
           format.html { render :new }
        end
      end
  end

  # PATCH/PUT /news_tags/1
  # PATCH/PUT /news_tags/1.json
  def update
    @news_tags = NewsTag.where("created_at > ?",24.hours.ago).order("created_at desc").limit(7)
    respond_to do |format|
      if @news_tag.update(news_tag_params)
        format.html { redirect_to @news_tag, notice: 'News tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_tag }
      else
        format.html { render :edit }
        format.json { render json: @news_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_tags/1
  # DELETE /news_tags/1.json
  def destroy
    @news_tag.destroy
    respond_to do |format|
      format.html { redirect_to news_tags_url, notice: 'News tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_tag
      @news_tag = NewsTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_tag_params
      params.require(:news_tag).permit(:title, :link)
    end

    def correct_user
       puts logged_in? && current_user.certificated
       redirect_to root_url unless logged_in? && current_user.certificated
    end
   
    def twitter_share
     client = Twitter::REST::Client.new do |config|
      # developer
      config.consumer_key         = OAUTH_CONFIG[:twitter]['key']
      config.consumer_secret      = OAUTH_CONFIG[:twitter]['secret']
      # user
      config.access_token         = "958240210923397120-F7mA6zAiu6e0cx4IN1PzQxE8Oy5cpfI" 
      config.access_token_secret  = "CeDNZydygOp82SxBEYvlf08QbXfJiyG9Jl3hrvRUqv88l"
     end
     return client
    end

    def facebook_share
     #graph = Koala::Facebook::API.new(result["token"].to_s)
     graph = FbGraph::User.me(result["token"].to_s)
     return graph
    end
end
