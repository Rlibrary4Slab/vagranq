module API
  module Ver1
    class ItemLikes < Grape::API
      version 'v1'
      format :json
      resource :item_likes do
  
       get ":authentication_token" do
	 present User.find_by(authentication_token: params[:authentication_token]).item_likes.order(created_at: :desc) ,with: Entity::V1::ItemLikesEntity
       end
      end
 
      
    end
  end
end
