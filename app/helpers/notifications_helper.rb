module NotificationsHelper
    
    def notification_savesend( articled, content, category)                   #いいね/閲覧の通知履歴を残して新着を飛ばす。
        notification = articled.user.notifications.build( user_id: articled.user_id, article_id: articled.id, content: content ,category: category, flag: false )
        notification.save
        
        notification_counts = @article.user.notifications.where(flag: false).count
        
        send = {category: category, article_title: articled.title, content: content, notification_counts: notification_counts, flag: false}
        notify = WebsocketRails.users[articled.user_id]
        notify.send_message(:notification_event, send)
    end
    
    def notification_destroy(notification)
        if notification.present?
            notification.destroy
        end
    end
    
end
