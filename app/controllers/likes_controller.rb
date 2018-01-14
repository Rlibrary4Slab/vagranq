class LikesController < ApplicationController
    include Notifications
    def like
        @article = Article.find(params[:article_id])
        like = current_user.likes.build(article_id: @article.id)
        user_discrime = current_user.id || "nonuser"
        Rails.cache.delete("views/#{user_discrime}/articles/#{@article.updated_at.strftime('%Y%m%d%H%M%S')}")
        if like.save
         REDIS.zincrby "user/#{@article.user_id}/likes/daily/#{Date.today.to_s}", 1, "#{@article.id}"
         REDIS.zincrby "user/#{@article.user_id}/likes", 1, "#{@article.id}"
         redis_likes_count = REDIS.zscore "user/#{@article.user_id}/likes", "#{@article.id}"
       
         #liked_article_counts = @article.likes_count.to_i + 1
         liked_article_counts = redis_likes_count.to_i 
         redis_total_liked_counts = REDIS.zrevrange "user/#{@article.user_id}/articles",0 ,-1,with_scores: true
         total_liked_counts =0
         redis_total_liked_counts.each do |like|

           total_liked_counts+= like.last.to_i 
         end
         #total_liked_counts = Article.where(user_id: @article.user_id).sum(:likes_count)

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
    end
    
    def unlike
        @article = Article.find(params[:article_id])
        like = current_user.likes.find_by(article_id: @article.id)
        user_discrime = current_user.id || "nonuser"
        Rails.cache.delete("views/#{user_discrime}/articles/#{@article.updated_at.strftime('%Y%m%d%H%M%S')}")
        if like.destroy
         REDIS.zincrby "user/#{@article.user_id}/likes/daily/#{Date.today.to_s}", -1, "#{@article.id}"
         REDIS.zincrby "user/#{@article.user_id}/likes", -1, "#{@article.id}"
        
         live_counter_likedown                                                                     #ライブカウンター

         notification = @article.notifications.where(category:1).find_by(content: like.id)
         notification_destroy(notification)
         if @article.likes_count.to_i % 5 == 0                                            #記事単体いいね数
            notification = @article.notifications.where(category:2).last
            notification_destroy(notification)
         end
         redis_total_liked_counts = REDIS.zrevrange "user/#{@article.user_id}/articles",0 ,-1,with_scores: true
         total_liked_counts =0
         redis_total_liked_counts.each do |like|

          total_liked_counts+= like.last.to_i 
         end
         if total_liked_counts % 30 == 29        #記事総合いいね数
         #if Article.where(user_id: @article.user_id).sum(:likes_count) % 30 == 29        #記事総合いいね数
         ##if Article.where(user_id: @article.user_id).sum(:likes_count) % 1 == 0        #記事総合いいね数
             notification = @article.notifications.where(category:3).last
             notification_destroy(notification)
         end
        end
    end

    def verify_like_or_not
    
      user = User.find_by(authentication_token: params[:session][:access_token])
      like = user.likes.find_by(article_id: params[:article_id])
      if like.nil?
 
        render text: user.user_name, status: 200
      else
	render text: like.id, status: 200
      end
    end

    def verify_like
        user = User.find_by(authentication_token: params[:session][:access_token])
        @article = Article.find(params[:article_id])
        like = user.likes.build(article_id: @article.id)
        user_discrime = user.id || "nonuser"
        Rails.cache.delete("views/#{user_discrime}/articles/#{@article.updated_at.strftime('%Y%m%d%H%M%S')}")
        if like.save
         REDIS.zincrby "user/#{@article.user_id}/likes/daily/#{Date.today.to_s}", 1, "#{@article.id}"
         REDIS.zincrby "user/#{@article.user_id}/likes", 1, "#{@article.id}"
         redis_likes_count = REDIS.zscore "user/#{@article.user_id}/likes", "#{@article.id}"

         #liked_article_counts = @article.likes_count.to_i + 1
         liked_article_counts = redis_likes_count.to_i
         redis_total_liked_counts = REDIS.zrevrange "user/#{@article.user_id}/articles",0 ,-1,with_scores: true
         total_liked_counts =0
         redis_total_liked_counts.each do |like|

           total_liked_counts+= like.last.to_i
         end
         #total_liked_counts = Article.where(user_id: @article.user_id).sum(:likes_count)

         notification_savesend(@article, like.id, 1, @article.eyecatch_img)                  #新着いいね

         live_counter_likeup                                                                     #ライブカウンター

         if liked_article_counts % 5 == 0                                                    #記事単体いいね数
            notification_savesend(@article, liked_article_counts, 2, @article.eyecatch_img)
         end
         if total_liked_counts % 30 == 0                                                     #記事総合いいね数
       # if total_liked_counts % 1 == 0                                                     #記事総合いいね数
            notification_savesend(@article, total_liked_counts, 3, user.user_image_url(:thumb))
         end
         render text: user.user_name, status: 200
        else
         render text: "だめみたいですね", status: 422
        end
    end

    def verify_unlike
      user = User.find_by(authentication_token: params[:session][:access_token])
      like = user.likes.find_by(article_id: params[:article_id])
      @article = Article.find(params[:article_id])
        user_discrime = user.id || "nonuser"
        Rails.cache.delete("views/#{user_discrime}/articles/#{@article.updated_at.strftime('%Y%m%d%H%M%S')}")
        if like.destroy
         REDIS.zincrby "user/#{@article.user_id}/likes/daily/#{Date.today.to_s}", -1, "#{@article.id}"
         REDIS.zincrby "user/#{@article.user_id}/likes", -1, "#{@article.id}"

         live_counter_likedown                                                                     #ライブカウンター

         notification = @article.notifications.where(category:1).find_by(content: like.id)
         notification_destroy(notification)
         if @article.likes_count.to_i % 5 == 0                                            #記事単体いいね数
            notification = @article.notifications.where(category:2).last
            notification_destroy(notification)
         end
         redis_total_liked_counts = REDIS.zrevrange "user/#{@article.user_id}/articles",0 ,-1,with_scores: true
         total_liked_counts =0
         redis_total_liked_counts.each do |like|

          total_liked_counts+= like.last.to_i
         end
         if total_liked_counts % 30 == 29        #記事総合いいね数
         #if Article.where(user_id: @article.user_id).sum(:likes_count) % 30 == 29        #記事総合いいね数
         ##if Article.where(user_id: @article.user_id).sum(:likes_count) % 1 == 0        #記事総合いいね数
             notification = @article.notifications.where(category:3).last
             notification_destroy(notification)
         end
          render text: user.user_name, status: 200
        else
          render text: "Token failed verification", status: 422
        end
    end
    
end
