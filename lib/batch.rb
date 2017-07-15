class Batch
  
  def self.hello
    puts "hello"
  end

  def self.yesterday_view_count
    users = User.all
    users.each do |user|
      yesterday_total_view = 0
      user.articles.each do |article|
        if article.aasm_state != "draft"
          #each_yesterday_view = REDIS.zscore "user/#{user.id}/articles/daily/#{Date.yesterday.to_s}", "#{article.id}"
          each_yesterday_view = REDIS.zscore "user/#{user.id}/articles/daily/#{Date.today.to_s}", "#{article.id}"
         # if each_yesterday_view.nil? #ここは閲覧数が読めてないページがあったときに必要だけど本番環境ならいらｎ
         #   each_yesterday_view = 0
         # end
          yesterday_total_view += each_yesterday_view.to_i
        end
      end
      if yesterday_total_view != 0 
       # puts user.id
       # puts yesterday_total_view
        notification = user.notifications.build( user_id: user.id, article_id:Time.now + user.id, content: yesterday_total_view, category: 6, flag: false ).save  #article_id is dummy data for avoidance of confliction
       # puts notification
      end
      
      wv = user.week_views.first
      wv.update(day6:wv.day5,day5:wv.day4,day4:wv.day3,day3:wv.day2,day2:wv.day1,day1:wv.day0)
      wv.update(day0: yesterday_total_view )
      
      puts "user_id:#{user.id}"
      for i in 0..6
        puts "day#{i} : #{wv.send("day#{i}")}"
      end   
        # 6.downto(1){ |i|
        #  user.week_views.first.update("day#{i}" => "day#{i-1}")
        # }
        # user.week_views.update( day0: yesterday_total_view )

        # for i in 1..6
        # user.week_views.first.send("day#{i}") = user.week_views.first.send("day#{i-1}")
    end
  end

  def self.initialize_data_of_week_view
    users = User.all
    users.each do |user|
      puts user.id
      wv = user.week_views.first
      wv.update(day6:6,day5:5,day4:4,day3:3,day2:2,day1:1,day0:0)
    #  wv.update(day0: yesterday_total_view )
      for i in 0..6
       print "day:"
       puts user.week_views.first.send("day#{i}")
      end
    end
  end


  def self.update_data_of_week_view
    users = User.all
    users.each do |user|
     yesterday_total_view = 0
     puts user.id
     wv = user.week_views.first
       for num in 0..6 do
         user.articles.each do |article|
          if article.aasm_state != "draft"
            each_yesterday_view = REDIS.zscore "user/#{user.id}/articles/daily/#{Date.today.advance(:days=>1-(num.to_i)).to_s}", "#{article.id}"
            yesterday_total_view += each_yesterday_view.to_i
          end
         end
       wv.update("day#{num}" => yesterday_total_view )
       print "day#{num}:"
       puts user.week_views.first.send("day#{num}")
       end
    end
  end

  def self.delete_old_notifications
    users = User.all
    users.each do |user|
     # old_notifications =  user.notifications.where("created_at < ?", Time.now.prev_month)
      user.notifications.where("created_at < ?", Time.now.prev_month).delete_all
     # old_notifications.each do |old_notification|
     #   puts old_notification.created_at
     # end
    end
  end

end
