class NotificationsController < ApplicationController
  def flag_off
    render :nothing => true
    flags = current_user.notifications.where(flag:false)
    flags.each do |flag|
      flag.update(flag:true)
    end
  end

  def paginate    #pagination ajaxにjsを読ませるために必要
  end
end
