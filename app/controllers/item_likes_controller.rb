class ItemLikesController < ApplicationController
    def like
        @item = Item.find(params[:item_id])
        like = current_user.item_likes.build(item_id: @item.id,article_id: params[:article_id])
        if like.save!
         render json: @item, only:[:item_likes_count]
        end
       
    end
    
    def unlike
        @item = Item.find(params[:item_id])
        unlike = current_user.item_likes.find_by(item_id: @item.id,article_id: params[:article_id])
        if unlike.destroy!
         render json: @item, only:[:item_likes_count]
        end
        
    end

    
end
