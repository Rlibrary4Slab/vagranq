
class LikesController < ApplicationController
    def like
        @article = Article.find(params[:article_id])
        like = current_user.likes.build(article_id: @article.id, liked_user_id: @article.user_id)
        like.save
        notification = @article.user.notifications.build( user_id: @article.user_id, article_id: @article.id, content: like.id ,category: 1, flag: false )
        notification.save
        
        notification_counts = @article.user.notifications.where(flag: false).count
        liked_article_counts = @article.liked.count                                     #counter_cacheの読み出し数が何故か1少ない。countクエリ使うのは効率悪い？
        total_liked_counts = @article.user.liked.count           #counter_cacheの方が効率が良いのであれば、なんとかこちらにも導入したい。
            
        send = {note_category:1, article_title: @article.title, notification_counts: notification_counts, flag: false}
        liked_notification = WebsocketRails.users[@article.user_id]
        liked_notification.send_message(:notification_event, send)

        if liked_article_counts % 5 == 0                                                    #記事単体いいね数
            notification = @article.user.notifications.build( user_id: @article.user_id, article_id: @article.id, content: liked_article_counts ,category:2 , flag: false )
            notification.save
            
            send = {note_category:2, article_title: @article.title, liked_count: liked_article_counts, notification_counts: notification_counts, flag: false }
            liked_notification = WebsocketRails.users[@article.user_id]
            liked_notification.send_message(:notification_event, send)
        end    
        if total_liked_counts % 30 == 0                                                        #記事総合いいね数
            notification = @article.user.notifications.build( user_id: @article.user_id, article_id: @article.id, content: total_liked_counts ,category:3 , flag: false )
            notification.save
        
            send = {note_category:3, article_title: @article.title, liked_count: total_liked_counts, notification_counts: notification_counts, flag: false }
            liked_notification = WebsocketRails.users[@article.user_id]
            liked_notification.send_message(:notification_event, send)
        end
    end
    
    def unlike
        @article = Article.find(params[:article_id])
        like = current_user.likes.find_by(article_id: @article.id)
        like.destroy
        notification = @article.notifications.where(category:1).find_by(content: like.id)
        notification.destroy
        
        if @article.user.liked.count % 5 == 4                                                        #記事総合いいね数
            notification = @article.notifications.where(category:3).last
            notification.destroy
        end
        if @article.liked.count % 30 == 29                                                        #記事総合いいね数
            notification = @article.notifications.where(category:2).last
            notification.destroy
        end
    end
    
end