class StaticPagesController < ApplicationController

  before_action :logged_in_user, only: [:index,:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :like_articles,:edit_articles]

  def home
    
    @articles = Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user)

    @rank = Article.published.limit(10).order(view_count: :desc).includes(:user)

    @toprank = Article.where(:corporecom => [1..3]).published.limit(3).includes(:user)
    
    @corporecom = Article.where(:corporecom => [100..300]).per_page_kaminari(params[:page]).published.limit(10).includes(:user)
     
  end
  
  
  
  def ranking
    #@articles = Article.published.per_page_kaminari(params[:page]).limit(10).order(view_count: :desc).includes(:user)
    @rank = Article.find(Like.group(:article_id).order('count(article_id) desc').limit(3).pluck(:article_id))
  end 
  
  def help
  end

  def agreement 
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
