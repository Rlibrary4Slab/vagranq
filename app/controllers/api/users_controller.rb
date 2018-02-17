class Api::UsersController < ApplicationController
    require "oauth"
    require "omniauth"
    require 'net/http'
    require 'uri'
    require 'json'
    before_action :set_user, only: [:guest_user_registration,:show, :edit, :update, :destroy]


    # GET /users
    def index
      @users= User.all
      render json: @users
    end
 
    def guest_user_registration
      if params["provider"] == "facebook"
       aToken = params[:accessToken]
       uri = URI.parse("https://graph.facebook.com/v2.8/me?&access_token=#{aToken}&fields=id,name,link")
       json = Net::HTTP.get(uri)
       result = JSON.parse(json)
     end
    
     if params["provider"] == "twitter"
      aToken = params[:authToken]
      aTokenSecret = params[:authTokenSecret]
      consumer= OAuth::Consumer.new("tvy3oyXU5kdIkZFJr6Fjqvycr", "Y2pO7ilI7cP4iX4DBhgsrQIYtyzXbPWlbLruMg9cADibJy9LQd", {:site=>"http://twitter.com",:scheme => :header})
      access_token = OAuth::AccessToken.new(consumer, aToken, aTokenSecret)
      response = access_token.request(:get, "https://api.twitter.com/1.1/account/verify_credentials.json")
      result = JSON.parse(response.body)
     end

       profile = SocialProfile.find_or_create_by(uid: result["id_str"], provider: params["provider"]) if params["provider"] == "twitter"
       profile = SocialProfile.find_or_create_by(uid: result["id"], provider: params["provider"]) if params["provider"] == "facebook"
       profile.save_oauth_twi_data!(result) if params["provider"] == "twitter"
       profile.save_oauth_face_data!(result) if params["provider"] == "facebook"
      # ユーザーを探す。
      # 第１候補：ログイン中のユーザー、第２候補：SocialProfileオブジェクトに紐付けされているユーザー。
      if !profile.user_id
      temp_email = "#{User::TEMP_EMAIL_PREFIX}-#{profile.uid}-#{profile.provider}.com"
	if params["provider"] == "twitter"
	     @user.update_attributes(
	       user_name: profile.name,
	       name: profile.nickname,
	       email:    temp_email,
	       user_description: profile.description,
	       password: Devise.friendly_token[0,20]
	     )
	end
	if params["provider"] == "facebook"
	  @user.update_attributes(
	       user_name: profile.name,
	       name: profile.uid,
	       email:    temp_email,
	       password: Devise.friendly_token[0,20])  
	end
        @user.remote_user_image_url = profile.image_url.gsub('http://','https://') unless @user.user_image.to_s != "thumb_thumb_illust-52.png"
        if @user.save
         profile.update!(user_id: @user.id) if profile.user != @user
         render json: @user.to_json(:include => :social_profiles),status: 200
        else
                 render json: @user,status: 400

        end
       else
        user = User.find(profile.user_id)
        user.generate_authentication_token
        render json: user.to_json(:include => :social_profiles),status: 200
       end
    end
    
    def oauth_loginuser
      # 認証データに対応するSocialProfileが存在するか確認し、なければSocialProfileを新規作成。
      # 認証データをSocialProfileオブジェクトにセットし、データベースに保存。
      if params["provider"] == "facebook"
       aToken = params[:accessToken]
       uri = URI.parse("https://graph.facebook.com/v2.8/me?&access_token=#{aToken}&fields=id,name,link")
       json = Net::HTTP.get(uri)
       result = JSON.parse(json)
     end
   
     if params["provider"] == "twitter"
      aToken = params[:authToken]
      aTokenSecret = params[:authTokenSecret]
      consumer= OAuth::Consumer.new("tvy3oyXU5kdIkZFJr6Fjqvycr", "Y2pO7ilI7cP4iX4DBhgsrQIYtyzXbPWlbLruMg9cADibJy9LQd", {:site=>"http://twitter.com",:scheme => :header})
      access_token = OAuth::AccessToken.new(consumer, aToken, aTokenSecret)
      response = access_token.request(:get, "https://api.twitter.com/1.1/account/verify_credentials.json")
      result = JSON.parse(response.body)
     end

       profile = SocialProfile.find_or_create_by(uid: result["id_str"], provider: params["provider"]) if params["provider"] == "twitter"
       profile = SocialProfile.find_or_create_by(uid: result["id"], provider: params["provider"]) if params["provider"] == "facebook"
       profile.save_oauth_twi_data!(result) if params["provider"] == "twitter"
       profile.save_oauth_face_data!(result) if params["provider"] == "facebook"
      # ユーザーを探す。
      # 第１候補：ログイン中のユーザー、第２候補：SocialProfileオブジェクトに紐付けされているユーザー。
      user = User.find_by(authentication_token: params[:auth]) 
      profile.update!(user_id: user.id) if profile.user != user
      render json: user.to_json(:include => :social_profiles),status: 200
    end

   
    def oauth_user
     if params["provider"] == "facebook"
       aToken = params[:accessToken]
       uri = URI.parse("https://graph.facebook.com/v2.8/me?&access_token=#{aToken}&fields=id,name,link")
       json = Net::HTTP.get(uri)
       result = JSON.parse(json)
     end
    
     if params["provider"] == "twitter"
      aToken = params[:authToken]
      aTokenSecret = params[:authTokenSecret]
      consumer= OAuth::Consumer.new("tvy3oyXU5kdIkZFJr6Fjqvycr", "Y2pO7ilI7cP4iX4DBhgsrQIYtyzXbPWlbLruMg9cADibJy9LQd", {:site=>"http://twitter.com",:scheme => :header})
      access_token = OAuth::AccessToken.new(consumer, aToken, aTokenSecret)
      response = access_token.request(:get, "https://api.twitter.com/1.1/account/verify_credentials.json")
      result = JSON.parse(response.body)
     end

       profile = SocialProfile.find_or_create_by(uid: result["id_str"], provider: params["provider"]) if params["provider"] == "twitter"
       profile = SocialProfile.find_or_create_by(uid: result["id"], provider: params["provider"]) if params["provider"] == "facebook"
       profile.save_oauth_twi_data!(result) if params["provider"] == "twitter"
       profile.save_oauth_face_data!(result) if params["provider"] == "facebook"
       #以下ログイン機能　現時点では万全　登録機能との兼ねあわせはきついかな？
        if profile.user 
            puts "socialari"
            user=  profile.user
             user.generate_authentication_token
             render json: user.to_json(:include => :social_profiles),status: 200
        else 
                temp_email = "#{User::TEMP_EMAIL_PREFIX}-#{profile.uid}-#{profile.provider}.com"
		if params["provider"] == "twitter"
		     user = User.new(
	               user_name: profile.name,
	               name: profile.nickname,
		       email:    temp_email,
		       user_description: profile.description,
		       password: Devise.friendly_token[0,20]
		     )
		end
		if params["provider"] == "facebook"
		     user = User.new(
		       user_name: profile.name,
		       name: profile.uid,
		       email:    temp_email,
		       password: Devise.friendly_token[0,20]
		     )
		end
                user.week_views.build(user_id:user.id, day6:0,day5:0,day4:0,day3:0,day2:0,day1:0,day0:0)
                user.attributes= {day_count_view: 0,certificated: false,count_articles: 0,
all_articles_views: 0,
period_count_articles: 0,
period_articles_views: 0,
total_likes: 0}
             if user.save
                user.remote_user_image_url = profile.image_url.gsub('http://','https://') unless user.user_image.to_s != "thumb_thumb_illust-52.png"

                profile.update!(user_id: user.id) if profile.user != user
                user.generate_authentication_token
                render json: user.to_json(:include => :social_profiles),status: 200
             else
                 render json: user,status: 400
             end
       end
    end

    # GET /users/1
    def show
      render json: @user
    end

    # GET /users/new
    def new
      @user = User.new
    end

    def twitter_auth_out
      if SocialProfile.where(provider: "twitter").find_by(user_id: current_user.id).destroy!
       render json: "Twitter認証を解除しました",status: 200
      else
       render json: "問題が発生しました" ,status: 400
      end
    end

    def facebook_auth_out
      if SocialProfile.where(provider: "facebook").find_by(user_id: current_user.id).destroy!
       render json: "Facebook認証を解除しました",status: 200
      else
       render json: "問題が発生しました" ,status: 400
      end
    end

    # GET /users/1/edit
    def edit
      if @user
        #render json: @user, only: [:email, :name],  status: 200
        render json: @user, status: 200
      else
        render text: "Unidentified user", status: 422
      end
    end

    # POST /users
    def create
      @user = User.new(user_params)
        if @user.save
          render text: @user.access_token, status: 201
        else
          render json: @user.errors, status: 422
        end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update_attributes(user_params)
        render json: @user, status: 200
      else
        render json: @user.errors, status: 422
      end
    end

    # DELETE /users/1
    def destroy
      if @user.destroy
        render text: "Account has been deleted successfuly", status: 200
      else
        render text: "Something went wrong", status: 422
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find_by(authentication_token: params[:access_token])
        #@user = User.find_by(authenticity_token: params[:authenticity_token])
        #@user = User.find_by(id: params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation ,:user_name,:count_articles,
:all_articles_views,
:period_count_articles,
:period_articles_views,
:total_likes)
      end
     

end
