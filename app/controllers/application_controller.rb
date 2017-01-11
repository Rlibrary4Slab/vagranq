class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    before_filter :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception
    include SessionsHelper
    # before_action :pvranking
  
  
    
    

    protected
    
    def configure_permitted_parameters
        # strong parametersを設定し、user_idを許可
        devise_parameter_sanitizer.permit(:sign_up){|u|
            u.permit(:name, :email,:password, :password_confirmation)
        }
        devise_parameter_sanitizer.permit(:sign_in){|u|
            u.permit(:name, :email,:password, :remember_me)
        }
    end
  
  
    def pvranking
      require 'google_api'
      api = GoogleApi.new
      api.authorize!
      analytics = api.get_pvranking(max_results: 10)
      @ranking  = JSON.parse(analytics.response.body)["rows"]
    end
end
