module API
  module Ver1
    class Likes < Grape::API
      version 'v1'
      format :json
      resource :likes do
       get do
        present Like.find_by(user_id: 5),with: Entity::V1::LikesEntity
       end
  
       get ":authentication_token" do
	 present User.find_by(authentication_token: params[:authentication_token]).likes.order(created_at: :desc).limit(10) ,with: Entity::V1::LikesEntity
       end
      end
 
      
    end
  end
end
