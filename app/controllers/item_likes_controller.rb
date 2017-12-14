class ItemLikesController < ApplicationController
    def like
        @item = Item.find(params[:item_id])
        like = current_user.item_likes.build(item_id: @item.id,article_id: params[:article_id])
        like.save
       
    end
    
    def unlike
        @item = Item.find(params[:item_id])
        like = current_user.item_likes.find_by(item_id: @item.id,article_id: params[:article_id])
        like.destroy
        
    end

    def verify_like_or_not

      user = User.find_by(authentication_token: params[:session][:access_token])
      like = user.item_likes.find_by(item_id: params[:item_id])
      if like.nil?

        render text: user.user_name, status: 200
      else
        render text: like.id, status: 201
      end
    end

    def verify_like
      user = User.find_by(authentication_token: params[:session][:access_token])
      like = user.item_likes.build(item_id: params[:item_id],article_id: params[:article_id])

        if like.save!
          render text: user.user_name, status: 200
        else
          render text: "Token failed verification", status: 422
        end
    end

    def verify_unlike
      user = User.find_by(authentication_token: params[:session][:access_token])
      like = user.item_likes.find_by(item_id: params[:item_id])

        if like.destroy
          render text: user.user_name, status: 200
        else
          render text: "Token failed verification", status: 422
        end
    end

    
end
