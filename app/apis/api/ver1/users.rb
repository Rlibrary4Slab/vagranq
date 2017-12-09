module API
  module Ver1
    class Users < Grape::API
      version 'v1'
      format :json
      resource :users do
       get do
        #user = User.find_by(id: params[:session][:id])
          #if user
           #render text: "verified", status: 200
           #present User.all.limit(1), with: Entity::V1::UsersEntity
          #else
          # render text: "Token failed verification", status: 422
          #end
       end
       get "/active/:authentication_token" do
	 present User.find_by(authentication_token: params[:authentication_token]),with:Entity::V1::UserLikeEntity
 
       end
  
       get ":authentication_token" do
	 present User.find_by(authentication_token: params[:authentication_token]) 
       end
       get ":authentication_token/likes" do
	 present User.find_by(authentication_token: params[:authentication_token]).likes.order(:updated_at).reverse,with: Entity::V1::LikeEntity
       end
       get ":authentication_token/itemlikes/spot" do
	 present User.find_by(authentication_token: params[:authentication_token]).item_likes.item_category(20).order(:updated_at).reverse,with: Entity::V1::ItemLikeEntity
       end
       get ":authentication_token/itemlikes/event" do
	 present User.find_by(authentication_token: params[:authentication_token]).item_likes.item_category(30).order(:updated_at).reverse,with: Entity::V1::ItemLikeEntity
       end
      end
 
      
    end
  end
end
