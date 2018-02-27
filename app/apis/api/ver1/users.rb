module API
  module Ver1
    class Users < Grape::API
      version 'v1'
      format :json
      resource :users do
       get do
        #user = User.find_by(id: params[:session][:id])
          #if user
           #render text: "verified", status: 200
           #present User.all.limit(1), with: Entity::V1::UsersEntity
          #else
          # render text: "Token failed verification", status: 422
          #end
       end
       get "/active/:authentication_token" do
	 #present User.find_by(authentication_token: params[:authentication_token]).joins(:likes,:itemlikes)#,with:Entity::V1::UserLikeEntity
	 
         #present User.find_by(authentication_token: params[:authentication_token]).likes.includes(:article).article_published
	 #present User.includes([likes: :article,item_likes: :item]).where("likes.article.aasm_state = ?" , "published").find_by(authentication_token: params[:authentication_token]),with:Entity::V1::UserLikeEntity 
         present User.includes([likes: :article,item_likes: :item]).find_by(authentication_token: params[:authentication_token]),with:Entity::V1::UserLikeEntity
         #present User.includes(:like_articles ,:like_items).per_page_kaminari(params[:page]).per(5).find_by(authentication_token: params[:authentication_token])#,with:Entity::V1::UserLikeEntity
         #present User.includes(:like_articles ,:like_items).per_page_kaminari(params[:page]).per(5).find_by(authentication_token: params[:authentication_token])#,with:Entity::V1::UserLikeEntity
 
       end
  
       get ":authentication_token" do
	 present User.find_by(authentication_token: params[:authentication_token]) 
       end
       get ":authentication_token/likes" do
	 present User.find_by(authentication_token: params[:authentication_token]).likes.order(:updated_at).includes(:article).where("articles.aasm_state = ?","published").references(:articles).limit(10),with: Entity::V1::LikeEntity
       end
       get ":authentication_token/itemlikes/spot" do
	 present User.find_by(authentication_token: params[:authentication_token]).item_likes.item_category(20).order(:updated_at).includes(:item).limit(10).reverse,with: Entity::V1::ItemLikeEntity
       end
       get ":authentication_token/itemlikes/event" do
	 present User.find_by(authentication_token: params[:authentication_token]).item_likes.item_category(30).order(:updated_at).includes(:item).limit(10).reverse,with: Entity::V1::ItemLikeEntity
       end
      end
 
      
    end
  end
end
