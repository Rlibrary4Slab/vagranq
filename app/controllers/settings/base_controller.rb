class Settings::BaseController < AuthorizedController
    before_action :exclusion_user
    def exclusion_user
     if logged_in?
      redirect_to root_url if current_user.exclusion != false
     end
    end
  
end
