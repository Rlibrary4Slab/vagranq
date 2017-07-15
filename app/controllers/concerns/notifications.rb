module Notifications
    
    def notification_savesend( articled, content, category,eyecatch_img)                   #いいね/閲覧の通知履歴を残して新着を飛ばす。
   
        notification = articled.user.notifications.build( user_id: articled.user_id, article_id: articled.id, content: content ,category: category, flag: false )
        #notification = articled.user.notifications.build(article_id: articled.id, content: content ,category: category, flag: false )
        notification.save
        
        notification_counts = @article.user.notifications.where(flag: false).count
        
        send = {category: category, article_title: articled.title, content: content, notification_counts: notification_counts, flag: false, eyecatch_img: eyecatch_img}
        notify = WebsocketRails.users[@article.user_id]
        notify.send_message(:notification_event, send)
    end
   
    def notification_destroy(notification)
        if notification.present?
            notification.destroy
        end
    end
    
    def live_counter_likeup
        notify = WebsocketRails.users[@article.user_id]
        data = {article_id:@article.id, content:@article.likes_count+1,total_content: @article.user.total_likes, user_id: @article.user.id}
        notify.send_message(:real_time_like, data)
    end

    def live_counter_likedown
        notify = WebsocketRails.users[@article.user_id]
        data = {article_id:@article.id, content:@article.likes_count-1,total_content: @article.user.total_likes, user_id: @article.user.id}
        notify.send_message(:real_time_like, data)
    end

    
    def live_counter_view
        notify = WebsocketRails.users[@article.user_id]
        data = {article_id:@article.id, user_id:@article.user_id}
        notify.send_message(:real_time_view, data)
    end
    
end
