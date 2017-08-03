module API
  module Ver1
    class Users < Grape::API
      version 'v1'
      format :json
      resource :articles do
        get do
           present Article.all.limit(1) #, with: Entity::V1::UsersEntity

        end
      end
      
      resource :contents do
        get do
           #present Content.find(1) #, with: Entity::V1::UsersEntity
           present Content.all.limit(1) #, with: Entity::V1::UsersEntity

        end
      end
    end
  end
end
