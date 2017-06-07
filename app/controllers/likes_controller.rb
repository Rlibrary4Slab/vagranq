class LikesController < ApplicationController
    include Notifications
    def like
        @article = Article.find(params[:article_id])
        like = current_user.likes.build(article_id: @article.id)
        like.save
       
        liked_article_counts = @article.likes_count.to_i + 1
        total_liked_counts = Article.where(user_id: @article.user_id).sum(:likes_count)

        notification_savesend(@article, like.id, 1)                                         #新着いいね
        if liked_article_counts % 5 == 0                                                    #記事単体いいね数
            notification_savesend(@article, liked_article_counts, 2)
        end    
        if total_liked_counts % 30 == 0                                                     #記事総合いいね数
            notification_savesend(@article, total_liked_counts, 3)
        end
    end
    
    def unlike
        @article = Article.find(params[:article_id])
        like = current_user.likes.find_by(article_id: @article.id)
        like.destroy
        
        notification = @article.notifications.where(category:1).find_by(content: like.id)
        notification_destroy(notification)
        if @article.likes_count % 5 == 4                                            #記事単体いいね数
            notification = @article.notifications.where(category:2).last
            notification_destroy(notification)
        end
        if Article.where(user_id: @article.user_id).sum(:likes_count) % 30 == 29        #記事総合いいね数
            notification = @article.notifications.where(category:3).last
            notification_destroy(notification)
        end
    end
    
end
