class Users::RegistrationsController < Devise::RegistrationsController
  
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def new
    build_resource({})
    respond_with self.resource
     
     
  end

  def create
    build_resource(sign_up_params)
    puts resource
    resource.week_views.build(user_id:resource.id, day6:0,day5:0,day4:0,day3:0,day2:0,day1:0,day0:0)
    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

 
  #def build_resource(hash=nil)
  #  hash[:uid] = User.create_unique_string
  #  super
  #end

  private

    def after_sign_in_path_for(resource)
      root_path
    end

    def after_sign_up_path_for(resource)
      root_path
    end

    def sign_up_params
      params.require(:user).permit(:name, :user_name,:email, :password, :password_confirmation,:admin, :pid,:provider)
    end

  protected
   def update_resource(resource, params)
    resource.update_without_password(params)
   end   
 
    
end
