class StaticPagesController < ApplicationController

  before_action :logged_in_user, only: [:index,:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :like_articles,:edit_articles]

  def home
    #@article_form = ArticleForm.new params[:article_form]
    #@search=@article_form.search
    #@micropost = current_user.microposts.build if logged_in?
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc")
    #@articles = Article.paginate(:page =>  params[:page]).published
    @user = User.find_by(name: params[:name])

    #@rank = Article.find(Like.group(:article_id).order('count(article_id) desc').order(created_at: :desc).limit(8).pluck(:article_id))
    
    #@rank = Article.published.where(:id => Like.group(:article_id).order('count(article_id) desc').pluck(:article_id))
    ids = Like.group(:article_id).order('count(article_id) desc').pluck(:article_id)
    @rank = Article.published.where(id: ids).order("field(id,#{ids.join(',')})")

    #@toprank = Article.find(Like.group(:article_id).where('updated_at >= ?', 24.hour.ago).order('count(article_id) desc').limit(3).pluck(:article_id))
    @toprank = Article.where(:corporecom => [1..3]).published.limit(3) 
    
    @corporecom = Article.where(:corporecom => [100..300]).per_page_kaminari(params[:page]).published.limit(10)
     
    @topcon = Article.topconed.order("count(corporecom) desc")
     #require 'google_api'
      #api = GoogleApi.new
      #api.authorize!
      #analytics = api.get_pvranking(max_results: 10)
      #@ranking  = JSON.parse(analytics.response.body)["rows"]
  end
  
  
  
  def rank
    @rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end 
  
  def help
  end
  
  private
  
    def set_user
      @user = User.find_by(name: params[:name])
    end
    
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
