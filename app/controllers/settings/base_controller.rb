class Settings::BaseController < AuthorizedController
    before_action :certificate_user
    def certificate_user
     if logged_in?
      redirect_to root_url if current_user.certificated != false
     end
    end
  
end
