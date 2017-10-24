class ItemLikesController < ApplicationController
    def like
        @item = Item.find(params[:item_id])
        like = current_user.item_likes.build(item_id: @item.id)
        like.save
       
    end
    
    def unlike
        @item = Item.find(params[:item_id])
        unlike = current_user.item_likes.find_by(item_id: @item.id)
        unlike.destroy
        
    end

    
end
