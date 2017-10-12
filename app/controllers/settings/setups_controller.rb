class Settings::SetupsController < Settings::BaseController

  before_filter do
    add_breadcrumb('プロフィール設定')
  end

  def index 
  end
  
  def edit
  
  end
  
  def update
    current_user.assign_attributes(user_params)
    puts current_user.name
    current_user.attributes= {user_name: current_user.name} 
    #current_user.update(user_name: current_user.name) 
    #if current_user.valid?
      
    if current_user.save

       redirect_to root_url
    else
      
      flash[:error] = "おかしい"
      render :guest 
    end
  end
  
  


  private

    def user_params
      params.require(:user).permit(:name,:email,:user_name, :user_description,:user_image,:header_image,:crop_x,:crop_y,:crop_w,:crop_h,:twi,:face)
    end


end
