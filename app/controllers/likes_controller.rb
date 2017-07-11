class LikesController < ApplicationController
    include Notifications
    def like
        @article = Article.find(params[:article_id])
        like = current_user.likes.build(article_id: @article.id)
        like.save
       
        liked_article_counts = @article.likes_count.to_i + 1
        total_liked_counts = Article.where(user_id: @article.user_id).sum(:likes_count)

        notification_savesend(@article, like.id, 1, @article.eyecatch_img)                                         #新着いいね
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
        like.destroy
        
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
    
end
