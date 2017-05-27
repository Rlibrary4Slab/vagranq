class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    before_filter :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception
    before_action :notification
    #protect_from_forgery with: :null_session
    include SessionsHelper
    # before_action :pvranking
    class Forbidden < ActionController::ActionControllerError; end
    class IpAddressRejected < ActionController::ActionControllerError; end

    #include ErrorHandlers if Rails.env.production? or Rails.env.staging? 
    #rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404     
    #def error_404
    # render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    #end
    #rescue_from ActiveRecord::RecordNotFound, with: :render_404
    #rescue_from ActionController::RoutingError, with: :render_404
    #rescue_from Exception, with: :render_500
    Fluent::Logger::FluentLogger.open(nil, :host=>'localhost', :port=>24224)
    before_action :fluentpost
    def fluentpost
     Fluent::Logger.post("myapp.access",{"url"=>request.fullpath,"time"=>Time.current.to_s})  
    end
    
    def notification
        if logged_in?
            # @likeds = current_user.liked.per_page_kaminari(params[:page]).order('created_at DESC')
            @notifications = current_user.notifications.per_page_kaminari(params[:page]).order('created_at DESC')
        end
    end

    
    private
     def render_404
      render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
     end

     def render_500
      render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
     end

    protected
    
     def configure_permitted_parameters
        # strong parametersを設定し、user_idを許可
        devise_parameter_sanitizer.permit(:sign_up){|u|
            u.permit(:name,:admin ,:email,:password, :password_confirmation)
        }
        devise_parameter_sanitizer.permit(:sign_in){|u|
            u.permit(:name, :email,:password, :remember_me)
        }
        devise_parameter_sanitizer.permit(:account_update){|u|
            u.permit(:name,:admin ,:email,:password, :password_confirmation)
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
