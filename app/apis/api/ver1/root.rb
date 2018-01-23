module Entity
  module V1
    class UserNameEntity < Grape::Entity
      expose :user_name
    end

    class UserPageEntity < Grape::Entity
      expose :user_name,:user_description
    end

    class ArticleEntity < Grape::Entity
      expose :id,:title,:description,:eyecatch_img,:view_count
      expose :user, using: Entity::V1::UserNameEntity
    end
    class ContentEntity < Grape::Entity
      expose :title,:description
    end

    class ArticleDetailEntity < Grape::Entity
      expose :id,:title,:description,:eyecatch_img
      #expose :user, using: Entity::V1::UserNameEntity
      expose :contents , using: Entity::V1::ContentEntity
    end

    class ItemEntity < Grape::Entity
      expose :id,:title,:address,:image
    end

    class ItemLikeEntity < Grape::Entity
      expose :id
      expose :item, using: Entity::V1::ItemEntity
    end
    class ArticleTitleEntity < Grape::Entity
      expose :id,:title,:eyecatch_img,:view_count
    end
   
    class LikeEntity < Grape::Entity
      expose :id
      expose :article, using: Entity::V1::ArticleTitleEntity
    end
    class UserLikeEntity < Grape::Entity
      expose :user_name,:user_description,:user_image,:total_likes,:all_articles_views
      expose :likes, using: Entity::V1::LikeEntity
      expose :item_likes ,using: Entity::V1::ItemLikeEntity
 
    end
  
    class NewsTagEntity < Grape::Entity
      expose :id ,:title,:link
      expose :article, using: Entity::V1::ArticleTitleEntity
    end
  end
end
module API
  module Ver1
    class Root < Grape::API

      # これでdomain/api/v1でアクセス出来るようになる。
      version 'v1', using: :path
      format :json

      mount API::Ver1::Users
      #mount API::Ver1::Likes
      mount API::Ver1::Articles
      mount API::Ver1::NewsTags
      mount API::Ver1::Items
      #mount API::Ver1::ItemLikes

      # 404NotFoundの扱い
      #route :any, '*path' do
      #  error! I18n.t('grape.errors.not_found'), 404
      #end

    end
  end
end
