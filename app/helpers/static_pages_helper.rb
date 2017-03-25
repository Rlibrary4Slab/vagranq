module StaticPagesHelper
 def daily_article_ranking
  ids = Impression.where("created_at >= ?", 30.days.ago).where("created_at <= ?", Time.now).group(:impressionable_id).order('count_all desc').limit(10).count.keys
  Article.where(:id => ids).order("field(id, #{ids.join(',')})")
 end
end
