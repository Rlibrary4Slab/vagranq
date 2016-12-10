class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
   @users = User.paginate(page: params[:page])
  end

  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find_by(name: params[:name])
    
  end
  
  
  def create
    @user = User.new(user_params)    # 実装は終わっていないことに注意!
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find_by(name: params[:name])
  end
   private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
