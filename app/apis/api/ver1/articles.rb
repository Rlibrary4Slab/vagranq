module API
  module Ver1
    class Articles < Grape::API
      version 'v1'
      format :json

      resource :articles do
        get do
           
            #puts REDIS.zrevrange "articles_ranking/daily/#{Date.today.to_s}/#{Time.now.to_time.strftime("%H00").to_s}", 0, -1, withscores: true
            #puts REDIS.zrevrange "articles_ranking/daily/#{Date.today.to_s}/2300", 0, -1 
 
            ids = if Time.now.to_time.strftime("%H00").to_s != "0000" 
                   #REDIS.zrevrange "articles_ranking/daily/#{Date.today.to_s}/1400", 0, -1
                   REDIS.zrevrange "articles_ranking/daily/#{Date.today.to_s}/#{Time.now.advance(:hours=> -1).to_time.strftime("%H00").to_s}", 0, 19 
           else
                   REDIS.zrevrange "articles_ranking/daily/#{Date.yesterday.to_s}/2300", 0, 19
           end
            at = !ids.empty? && ids.count >10 ? Article.per_page_kaminari(params[:page]).published.where(:id => ids).order("field(id, #{ids.join(',')})") : Article.per_page_kaminari(params[:page]).published.order("updated_at desc") 
            
            present at , with: Entity::V1::ArticleEntity     
        end
      end
 
      get "/articles/:id" do
	@article = Article.find(params[:id])
        redis_category = "fashion" if @article.category == "ファッション"
        redis_category = "beauty" if @article.category == "美容健康"
        redis_category = "hangout" if @article.category == "おでかけ"
        redis_category = "gourmet" if @article.category == "グルメ"
        redis_category = "lifestyle" if @article.category == "ライフスタイル"
        redis_category = "entertainment" if @article.category == "エンタメ"
        redis_category = "interior" if @article.category == "インテリア"
        redis_category = "gadget" if @article.category == "ガジェット"
        redis_category = "learn" if @article.category == "学び"
        redis_category = "funny" if @article.category == "おもしろ"
        #puts "aaa|#{at.user_id}|#{params[:id]}"
        REDIS.zincrby "articles/category/#{redis_category}/daily/#{Date.today.to_s}", 1, "#{@article.id}"
        REDIS.zincrby "articles/category/#{redis_category}", 1, "#{@article.id}"
        REDIS.zincrby "articles_ranking/daily/#{Date.today.to_s}", 1, "#{@article.id}"
        REDIS.zincrby "articles_ranking/daily/#{Date.today.to_s}/#{Time.now.to_time.strftime("%H00").to_s}", 1, "#{@article.id}"
        REDIS.zincrby "articles_ranking", 1, "#{@article.id}"
        REDIS.zincrby "user/#{@article.user_id}/articles/daily/#{Date.today.to_s}", 1, "#{@article.id}"
        REDIS.zincrby "user/#{@article.user_id}/articles", 1, "#{@article.id}"
        @page_views_get_all = REDIS.zscore "user/#{@article.user_id}/articles","#{params[:id]}"
        @page_views = @page_views_get_all.to_i

        @article.update_columns(view_count: @page_views)
        #present at
        present @article, with: Entity::V1::ArticleDetailEntity
      end
      
    end
  end
end
