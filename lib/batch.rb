class Batch
  
#routine#
#---------------------------------------------------------------------------------------------------------------------#
  def self.newsToPublish
    Article.where.not(aasm_state: "published").where(id: NewsTag.where("created_at < ?",24.hours.ago).map(&:link)).each {|article| 
       article.publish!
    }
    NewsCrawler.where("created_at<?", 24.hours.ago ).each{|news| news.destroy! }
  end

  def self.yesterday_view_count
    users = User.all
    users.each {|user|
      yesterday_total_view = 0
      user_yesterday_views = REDIS.zrevrange "user/#{user.id}/articles/daily/#{Date.yesterday.to_s}",0 ,-1,with_scores: true
      user_yesterday_views.each {|view|
        yesterday_total_view+=view.last.to_i
      }
      #user.articles.each do |article|
        #if article.aasm_state != "draft"
          #each_yesterday_view = REDIS.zscore "user/#{user.id}/articles/daily/#{Date.yesterday.to_s}", "#{article.id}"
        #  each_yesterday_view = REDIS.zscore "user/#{user.id}/articles/daily/#{Date.today.to_s}", "#{article.id}"
          #if each_yesterday_view.nil? #it's needed when it cannot read view for nil
          #  each_yesterday_view = 0
          #end
          #yesterday_total_view += each_yesterday_view.to_i
        #end
      #end
      if yesterday_total_view != 0 
       # puts user.id
       # puts yesterday_total_view
        notification = user.notifications.build( user_id: user.id, article_id:Time.now + user.id, content: yesterday_total_view, category: 6, flag: false ).save  #article_id is dummy data for avoidance of confliction
       # puts notification
      end
      
      wv = user.week_views.first
      wv.update(day6:wv.day5,day5:wv.day4,day4:wv.day3,day3:wv.day2,day2:wv.day1,day1:wv.day0)
      wv.update(day0: yesterday_total_view )
      
     # puts "user_id:#{user.id}"
     # for i in 0..6
     #   puts "day#{i} : #{wv.send("day#{i}")}"
     # end   
     # 6.downto(1){ |i|
     #  user.week_views.first.update("day#{i}" => "day#{i-1}")
     # }
     # user.week_views.update( day0: yesterday_total_view )

     # for i in 1..6
     # user.week_views.first.send("day#{i}") = user.week_views.first.send("day#{i-1}")
    }
  end

  def self.delete_old_notifications
    users = User.all
    users.each {|user|
     # old_notifications =  user.notifications.where("created_at < ?", Time.now.prev_month)
      user.notifications.where("created_at < ?", Time.now.prev_month).delete_all
     # old_notifications.each do |old_notification|
     #   puts old_notification.created_at
     # end
    }
  end

  def self.user_ranking_point
    users = User.all
    users.each {|user|
      today_user_view_point = user.day_count_view * 0.9 + user.week_views.first.day0
      user.update(day_count_view:today_user_view_point)
      #puts "user_id:#{user.id}"
      #puts "day_count_view:#{user.day_count_view}"
      #puts "------------------"
    }
  end
  
  def self.user_status_set
    users = User.all
    users.each {|user|
     user_total_view=0
     user_article_views = REDIS.zrevrange "user/#{user.id}/articles",0 ,-1,with_scores: true
     user_article_views.each{ |view|
        user_total_view += view.last.to_i
     }
     user_total_like = 0
     user_likes = REDIS.zrevrange "user/#{user.id}/likes",0 ,-1,with_scores: true
     user_likes.each { |view|
        user_total_like += view.last.to_i
     }
     status_score = user_total_view + 30 * user_total_like     
     user.update_attributes(writer_status: 10) if status_score < 10000 
     user.update_attributes(writer_status: 20) if status_score > 10000 && @user.writer_status == "ホワイト"
     user.update_attributes(writer_status: 30) if status_score > 30000 && @user.writer_status == "ブルー"
    }
  end

  
#one-time#
#---------------------------------------------------------------------------------------------------------------------#

  def self.hello
    puts "hello"
  end

  def self.initialize_data_of_week_view
    users = User.all
    users.each do |user|
      puts "user_id=#{user.id}"
      wv = user.week_views
      wv.build(user_id:user.id).save      #building data schema at first
      wv = user.week_views.first
      wv.update(day6:6,day5:5,day4:4,day3:3,day2:2,day1:1,day0:0)       #adding dummy data of date
      for i in 0..6
       print "day#{i}:"
       puts user.week_views.first.send("day#{i}")
      end
    end
  end
  
  def self.initialize_data_of_week_view_for_new_user
    users = User.all
    users.each do |user|
      puts "user_id=#{user.id}"
      wv = user.week_views
      if wv.empty?
        wv.build(user_id:user.id).save      #building data schema at first
        wv = user.week_views.first
        wv.update(day6:0,day5:0,day4:0,day3:0,day2:0,day1:0,day0:0)       #adding dummy data of date
      end
        for i in 0..6 
          print "day#{i}:"
          puts wv.first.send("day#{i}")
        end
    end
  end

  def self.update_data_of_week_view
    users = User.all
    users.each do |user|
     puts user.id
     wv = user.week_views.first
       for num in 0..6 do
         yesterday_total_view = 0
         user.articles.each do |article|
          if article.aasm_state != "draft"
            each_yesterday_view = REDIS.zscore "user/#{user.id}/articles/daily/#{Date.today.advance(:days=>-1-(num.to_i)).to_s}", "#{article.id}"
            yesterday_total_view += each_yesterday_view.to_i
          end
         end
       wv.update("day#{num}" => yesterday_total_view )
       print "day#{num}:"
       puts user.week_views.first.send("day#{num}")
       end
    end
  end

  def self.total_likes_count
    users = User.all
    users.each do |user|
      total_likes_count = 0
      user.articles.each do |article|
        total_likes_count += article.likes_count
      end
      user.update(total_likes: total_likes_count)
      puts "user_id:#{user.id}"
      puts "total_likes:#{user.total_likes}"
    end
  end

  def self.initialize_user_ranking_point
    users = User.all
    users.each do |user|
      puts "user_id:#{user.id}"
      two_weeks_view = 0  
      for num in -1..29 do
        each_view = 0
        user.articles.each do |article|
          if article.aasm_state != "draft"
            each_view = REDIS.zscore "user/#{user.id}/articles/daily/#{Date.today.advance(:days=>-1-(num.to_i)).to_s}", "#{article.id}"
            two_weeks_view += each_view.to_i     #accumulative view count
          end
        end
    #  print "day#{num}:#{two_weeks_view}"
    #  puts ""
      end
      puts "30日前の総閲覧数：#{user.articles.sum(:view_count) - two_weeks_view}. これに0.9掛けて19日前の閲覧数を足せば、18日前のポイントが算出される"
      two_weeks_ago_point = ( user.articles.sum(:view_count) - two_weeks_view ) *0.9
      each_day_view = 0
      28.downto(1){ |numi|
        each_view = 0
        user.articles.each do |article|
          each_view = REDIS.zscore "user/#{user.id}/articles/daily/#{Date.today.advance(:days=>-1-(numi.to_i)).to_s}", "#{article.id}"
          each_day_view += each_view.to_i
        end
        two_weeks_ago_point += each_day_view
        puts "#{numi}日前のポイント：#{two_weeks_ago_point}"
        two_weeks_ago_point *= 0.9
      }
      puts "↑30日前に遡っての計算過程"
      day_count_view = two_weeks_ago_point + user.week_views.first.day0
      user.update(day_count_view: day_count_view)
      puts "1日前の閲覧数：#{user.week_views.first.day0}"
      puts "現在のポイントを保存:#{user.day_count_view}"
      puts "------------------------------------"
    end
  end

end
