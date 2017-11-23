module Entity
  module V1
    class ArticlesEntity < Grape::Entity
      expose :id,:title,:eyecatch_img,:view_count
      unexpose :contents
    end

    class LikesEntity < Grape::Entity
      expose :id
      #unexpose :user #, using: Entity::V1::UsersEntity
      expose :article, using: Entity::V1::ArticlesEntity
    end




  end
end

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
	 present User.find_by(authentication_token: params[:authentication_token]).likes.order(created_at: :desc) ,with: Entity::V1::LikesEntity
       end
      end
 
      
    end
  end
end
