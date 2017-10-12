module Entity
  module V1
    class ContentsEntity < Grape::Entity
      expose :title
    end

    class UsersEntity < Grape::Entity
      expose :user_name
    end


    class ArticlesEntity < Grape::Entity
      expose :id,:title,:eyecatch_img,:view_count
      expose :user, using: Entity::V1::UsersEntity
      expose :contents , using: Entity::V1::ContentsEntity
    end

    class ArticleDetailEntity < Grape::Entity
      expose :id,:title,:description,:eyecatch_img,:view_count
      expose :user, using: Entity::V1::UsersEntity
      expose :contents , using: Entity::V1::ContentsEntity
    end

  end
end

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
  
       get ":authentication_token" do
	 present User.find_by(authentication_token: params[:authentication_token]).likes with: Entity::V1::ArticlesLikesEntity
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
      #  get ":id" do
	  #at = Article.find(params[:id])
          #          present Article.all.limit(2)
      #    present Article.find(params[:id]), with: Entity::V1::ArticleDetailEntity
      #  end
      #end
 
      
      resource :contents do
        get do
           #present Content.find(1) #, with: Entity::V1::UsersEntity
           present Content.find(96) , with: Entity::V1::ContentsEntity

        end
      end
    end
  end
end
