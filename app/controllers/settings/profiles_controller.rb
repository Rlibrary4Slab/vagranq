class Settings::ProfilesController < Settings::BaseController

  before_filter do
    add_breadcrumb('プロフィール設定')
  end

  
  def edit
  
  end
  
  def update
    current_user.assign_attributes(user_params)

    if current_user.valid?
      if params[:user][:user_name].present?
        case params[:user][:twi]
       when "1"
         current_user.twitter_s = true
       when "0"
         current_user.twitter_s = false
       end
      end

      if params[:user][:user_name].present?
       case params[:user][:face]
       when "1"
         current_user.facebook_s = true
       when "0"
         current_user.facebook_s = false
       end
      end


      current_user.save!
      if params[:user][:user_image].present?
        render :crop,layout: "user_page"
      else
        flash[:success] = '保存しました'
        redirect_to action: :edit
      end
    else
      flash[:error] = "おかしい"
      render :edit
    end
  end
  
  def share_facebook
    current_user.update_attributes(:facebook_s => !current_user.facebook_s  )
  end
  def share_twitter
    current_user.update_attributes(:twitter_s => !current_user.twitter_s  )
  end




  private

    def user_params
      params.require(:user).permit(:name,:email,:user_name, :user_description,:user_image,:header_image,:crop_x,:crop_y,:crop_w,:crop_h,:twi,:face)
    end


end
