class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    before_filter :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token,     if: -> {request.format.json?}
  # トークンによる認証
    before_action      :authenticate_user_from_token!, if: -> {params[:email].present?}
    before_action :notification
    #protect_from_forgery with: :null_session
    include SessionsHelper
    # before_action :pvranking
    class Forbidden < ActionController::ActionControllerError; end
    class IpAddressRejected < ActionController::ActionControllerError; end
    include ErrorHandlers if Rails.env.production? or Rails.env.staging? 
    #rescue_from ActiveRecord::RecordNotFound, with: :render_404 
    #rescue_from ActionController::RoutingError, with: :render_404 
    #rescue_from Exception, with: :render_500 
    rescue_from ActiveRecord::RecordNotFound, with: :render_404 if Rails.env.production?
    rescue_from ActionController::RoutingError, with: :render_404 if Rails.env.production?
    rescue_from Exception, with: :render_500 if Rails.env.production?
    #Fluent::Logger::FluentLogger.open(nil, :host=>'localhost', :port=>24224)
    #before_action :fluentpost
    #def fluentpost
    # Fluent::Logger.post("myapp.access",{"url"=>request.fullpath,"time"=>Time.current.to_s})  
    #end
    
    
    def notification
        if logged_in?
            # @likeds = current_user.liked.per_page_kaminari(params[:page]).order('created_at DESC')
            @notifications = current_user.notifications.per_page_kaminari(params[:page]).order('created_at DESC')
        end
    end

    def render_404
     #redirect_to root_path
    # render template: 'errors/error_404', status: 404, layout: false, content_type: 'text/html'
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
    end

    def render_500
     #redirect_to root_path
    render file: Rails.root.join('public/500.html'), status: 404, layout: false, content_type: 'text/html'
    end

    protected
    
     def configure_permitted_parameters
        # strong parametersを設定し、user_idを許可
        devise_parameter_sanitizer.permit(:sign_up){|u|
            u.permit(:name,:admin ,:email,:password, :password_confirmation)
        }
        devise_parameter_sanitizer.permit(:sign_in){|u|
            u.permit(:login,:name, :email,:password, :remember_me)
        }
        devise_parameter_sanitizer.permit(:account_update){|u|
            u.permit(:name,:admin ,:email,:password, :password_confirmation)
        }
     end
     def authenticate_user_from_token!
      user = User.find_by(email: params[:email])
      if Devise.secure_compare(user.try(:authentication_token), params[:token])
        sign_in user, store: false
      end
     end
  
  
     def pvranking
      require 'google_api'
      api = GoogleApi.new
      api.authorize!
      analytics = api.get_pvranking(max_results: 10)
      @ranking  = JSON.parse(analytics.response.body)["rows"]
     end
end
