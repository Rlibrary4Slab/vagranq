class Settings::ProfilesController < Settings::BaseController

  before_filter do
    add_breadcrumb('プロフィール設定')
  end
  
  def edit
  
  end
  
  def update
    current_user.assign_attributes(user_params)

    if current_user.valid?
      current_user.save!
      if params[:user][:user_image].present?
        render :crop
      else
        flash[:success] = '保存しました'
        redirect_to action: :edit
      end
    else
      flash[:error] = "おかしい"
      render :edit
    end
  end
  


  private

    def user_params
      params.require(:user).permit(:user_name, :user_description,:user_image,:header_image,
                                  :crop_x,:crop_y,:crop_w,:crop_h)
    end
end
