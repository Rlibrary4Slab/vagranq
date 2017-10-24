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
    if resource.name != "ranqmedia1" && resource.email != "ranq1@media.com"
       if resource.name !~ /^guest00[0-9+]+$/
	   resource.week_views.build(user_id:resource.id, day6:0,day5:0,day4:0,day3:0,day2:0,day1:0,day0:0)
	   resource.attributes= {user_name: resource.name,day_count_view: 0,certificated: false}
	   if resource.save
	     puts resource.id
	     resource.generate_authentication_token

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
        else
	     #clean_up_passwords resource
	     #set_flash_message :notice, :"そのユーザーはすでに登録されています" if is_flashing_format?
             flash[:error] = "そのユーザーはすでに登録されています"
	     redirect_to :back 

        end
    else
       puts resource.name 
       puts resource.email 
       resource.week_views.build(user_id:resource.id, day6:0,day5:0,day4:0,day3:0,day2:0,day1:0,day0:0)
       if resource.save
         puts resource.id
         resource.attributes= {name:"guest00"+resource.id.to_s, user_name: "ゲスト",
                             email: "guest00"+resource.id.to_s+"@guest00"+resource.id.to_s+".com"}
         resource.generate_authentication_token

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
      params.require(:user).permit(:name, :user_name,:email, :password, :password_confirmation,:admin, :pid,:provider,:day_count_view,:certificated)
    end

  protected
   def update_resource(resource, params)
    resource.update_without_password(params)
   end   
 
    
end
