module Entity
  module V1
    
    class ArticlesEntity < Grape::Entity
      expose :title,:view_count
      #expose :user_name, using: Entity::V1::UsersEntity 	
    end

    class UsersEntity < Grape::Entity
      expose :name, :email
    end
  end
end
