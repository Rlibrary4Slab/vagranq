module API
  module Ver1
    class Articles < Grape::API
      version 'v1'
      format :json

      resource :articles do
        get do
            present Article.per_page_kaminari(params[:page]).published.order("updated_at desc"), with: Entity::V1::ArticleEntity
        end
      end
 
      get "/articles/:id" do
	at = Article.find(params[:id])
        #puts "aaa|#{at.user_id}|#{params[:id]}"
        REDIS.zincrby "user/#{at.user_id}/articles/daily/#{Date.today.to_s}", 1, "#{params[:id]}"
        REDIS.zincrby "user/#{at.user_id}/articles", 1, "#{params[:id]}"
        @page_views_get_all = REDIS.zscore "user/#{at.user_id}/articles","#{params[:id]}"
        @page_views = @page_views_get_all.to_i

        at.update_columns(view_count: @page_views)
        #present at
        present at, with: Entity::V1::ArticleDetailEntity
      end
      
    end
  end
end
