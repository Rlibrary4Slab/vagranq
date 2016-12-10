module ArticlesHelper
    def likes_counter(likes)
        likes.count
    end
    
    def daily_article_ranking
        ids = Impression.where("created_at >= ?", Time.now.yesterday).where("created_at <= ?", Time.now).group(:impressionable_id).order('count_all desc').limit(10).count.keys
        Article.where(:id => ids).order("field(id, #{ids.join(',')})")
    end
end
