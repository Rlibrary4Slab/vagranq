class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  #POST /resource/sign_in
   def create
    super do |resource|
      resource.ensure_authentication_token if request.format.json?
    end
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  def verify_access_token
      user = User.find_by(id: params[:session][:id])
        if user
          render text: "verified", status: 200
        else
          render text: "Token failed verification", status: 422
        end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
