class LikesController < ApplicationController
    include Notifications
    def like
        @article = Article.find(params[:article_id])
        like = current_user.likes.build(article_id: @article.id)
        user_discrime = current_user || "nonuser"
        Rails.cache.delete("views/#{user_discrime}/articles/#{@article.id}")
        like.save
       
        liked_article_counts = @article.likes_count.to_i + 1
        total_liked_counts = Article.where(user_id: @article.user_id).sum(:likes_count)

        notification_savesend(@article, like.id, 1, @article.eyecatch_img)                  #新着いいね

        live_counter_likeup                                                                     #ライブカウンター

        if liked_article_counts % 5 == 0                                                    #記事単体いいね数
            notification_savesend(@article, liked_article_counts, 2, @article.eyecatch_img)
        end    
        if total_liked_counts % 30 == 0                                                     #記事総合いいね数
       # if total_liked_counts % 1 == 0                                                     #記事総合いいね数
            notification_savesend(@article, total_liked_counts, 3, current_user.user_image_url(:thumb))
        end
    end
    
    def unlike
        @article = Article.find(params[:article_id])
        like = current_user.likes.find_by(article_id: @article.id)
        user_discrime = current_user || "nonuser"
        Rails.cache.delete("views/#{user_discrime}/articles/#{@article.id}")
        like.destroy
        
        live_counter_likedown                                                                     #ライブカウンター

        notification = @article.notifications.where(category:1).find_by(content: like.id)
        notification_destroy(notification)
        if @article.likes_count.to_i % 5 == 0                                            #記事単体いいね数
            notification = @article.notifications.where(category:2).last
            notification_destroy(notification)
        end
        if Article.where(user_id: @article.user_id).sum(:likes_count) % 30 == 29        #記事総合いいね数
        #if Article.where(user_id: @article.user_id).sum(:likes_count) % 1 == 0        #記事総合いいね数
            notification = @article.notifications.where(category:3).last
            notification_destroy(notification)
        end
    end

    def verify_like_or_not
    
      user = User.find_by(authentication_token: params[:session][:access_token])
      like = user.likes.find_by(article_id: params[:article_id])
      puts like.nil?
      if like.nil?
 
        render text: user.user_name, status: 200
      else
	render text: like.id, status: 200
      end
    end

    def verify_like
      user = User.find_by(authentication_token: params[:session][:access_token])
      like = user.likes.build(article_id: params[:article_id])
      
        if like.save 
          render text: user.user_name, status: 200
        else
          render text: "だめみたいですね", status: 422
        end
    end

    def verify_unlike
      user = User.find_by(authentication_token: params[:session][:access_token])
      #@article = Article.find(params[:article_id])
      like = user.likes.find_by(article_id: params[:article_id])
      #like.destroy
      
        if like.destroy
          render text: user.user_name, status: 200
        else
          render text: "Token failed verification", status: 422
        end
    end
    
end
