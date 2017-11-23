module Entity
  module V1
    #Articleにはすでに記述済みであるためListについては考えなくていい
    class ItemDaySpotEntity < Grape::Entity
      expose :mon,:tue,:wed,:thu,:fri,:sat,:sun,:hol,:begin_time,:finish_time 
    end


    class ItemDayEventEntity < Grape::Entity
      expose :begin_time,:finish_time,:begin_day,:finish_day 
    end

    class ItemDetailSpotEntity < Grape::Entity
      expose :id,:title,:description,:address,:image,:category,:latitude,:longitude,:phonenumber,:remark
      expose :item_days , using: Entity::V1::ItemDaySpotEntity
      expose :item_spots
    end

    class ItemDetailEventEntity < Grape::Entity
      expose :id,:title,:description,:address,:image,:category,:latitude,:longitude,:phonenumber,:remark,:tag_list
      expose :item_days , using: Entity::V1::ItemDayEventEntity
     
    end
    class VerifyItemLike < Grape::Entity
     expose :item_likes
    end
  end
end

module API
  module Ver1
    class Items < Grape::API
      version 'v1'
      format :json
 
      get "/items/:id" do
	at = Item.find(params[:id])
        if at.category == "スポット"
         present at, with: Entity::V1::ItemDetailSpotEntity
        elsif at.category == "イベント"
         present at, with: Entity::V1::ItemDetailEventEntity
        end
      end
    
      get 
      
    end
  end
end
