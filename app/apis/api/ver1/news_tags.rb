module API
  module Ver1
    class NewsTags < Grape::API
      version 'v1'
      format :json

      resource :news_tags do
        get do
            present NewsTag.where("created_at > ?",1.days.ago).order("created_at desc").limit(7)
        end
        get ":id" do
          REDIS.zincrby "news_tag/clicked", 1, "#{params[:id]}"
          present "hoge" 
        end
      end
 
      
    end
  end
end
