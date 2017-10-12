module Entity
  module V1
    class ContentsEntity < Grape::Entity
      expose :title
    end

    class LikesEntity < Grape::Entity
      expose :id
      unexpose :user#, using: Entity::V1::UsersEntity
      expose :article, using: Entity::V1::ArticlesEntity
    end


    class ArticlesEntity < Grape::Entity
      expose :id,:title,:eyecatch_img,:view_count
      unexpose :user
      unexpose :contents
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
  
        #user = User.find_by(id: params[:session][:id])
          #if user
           #render text: "verified", status: 200
           #present User.all.limit(1), with: Entity::V1::UsersEntity
          #else
          # render text: "Token failed verification", status: 422
          #end
       end
  
       get ":authentication_token" do
	 present User.find_by(authentication_token: params[:authentication_token]).likes.order(created_at: :desc) ,with: Entity::V1::LikesEntity
       end
      end
      #resource :articles do
      #  get do
            #present Article.first().contents#, with: Entity::V1::ArticlesEntity
      #      present Article.all.limit(2), with: Entity::V1::ArticlesEntity
            #Article.all.limit(1).each do |article|  #, with: Entity::V1::UsersEntity
             #present article, with: Entity::V1::ArticlesEntity
             #present article.as_json.merge({user_name: user.user_name})
            #end
      #  end
      #end
 
      
    end
  end
end
