module Entity
  module V1

    class ArticlesEntity < Grape::Entity
      expose :id,:title,:description,:eyecatch_img,:view_count
      expose :user, using: Entity::V1::UsersEntity
    end

    class ArticleDetailEntity < Grape::Entity
      expose :id,:title,:description,:eyecatch_img,:view_count,:likes_count
      expose :user, using: Entity::V1::UsersEntity
      expose :contents , using: Entity::V1::ContentsEntity
    end

    class ContentsEntity < Grape::Entity
      expose :title,:description
    end

    class UsersEntity < Grape::Entity
      expose :user_name
    end
  end
end

module API
  module Ver1
    class Articles < Grape::API
      version 'v1'
      format :json

      resource :articles do
        get do
            #present Article.all.published.limit(2), with: Entity::V1::ArticlesEntity
            present Article.per_page_kaminari(params[:page]).published.order("updated_at desc").includes(:user), with: Entity::V1::ArticlesEntity
            #Article.all.limit(1).each do |article|  #, with: Entity::V1::UsersEntity
             #present article, with: Entity::V1::ArticlesEntity
             #present article.as_json.merge({user_name: user.user_name})
            #end
        end
      end
 
      get "/articles/:id" do
	at = Article.find(params[:id])
        #present at
        present at, with: Entity::V1::ArticleDetailEntity
      end
      
      resource :contents do
        get do
           #present Content.find(1) #, with: Entity::V1::UsersEntity
           present Content.find(96) , with: Entity::V1::ContentsEntity

        end
      end
    end
  end
end
