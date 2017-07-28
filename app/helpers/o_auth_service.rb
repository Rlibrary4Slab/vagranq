module OAuthService
  class GetOAuthUser

    def self.logcall(auth,current_user)
      # 認証データに対応するSocialProfileが存在するか確認し、なければSocialProfileを新規作成。
      # 認証データをSocialProfileオブジェクトにセットし、データベースに保存。
      profile = SocialProfile.find_for_oauth(auth)
      # ユーザーを探す。
      # 第１候補：ログイン中のユーザー、第２候補：SocialProfileオブジェクトに紐付けされているユーザー。
      user = current_or_profile_user(profile)
      unless user
        # 第３候補：認証データにemailが含まれていればそれを元にユーザーを探す。
        #user = User.where(email: email).first if verified_email_from_oauth(auth)
        # 見つからなければ、ユーザーを新規作成。
        #user ||= find_or_create_new_user(auth)
        profile.email = current_user.email
      end
      associate_user_with_profile!(current_user, profile)
      current_user
    end


    def self.call(auth)
      # 認証データに対応するSocialProfileが存在するか確認し、なければSocialProfileを新規作成。
      # 認証データをSocialProfileオブジェクトにセットし、データベースに保存。
      profile = SocialProfile.find_for_oauth(auth)
      # ユーザーを探す。
      # 第１候補：ログイン中のユーザー、第２候補：SocialProfileオブジェクトに紐付けされているユーザー。
      user = current_or_profile_user(profile)
      unless user
        # 第３候補：認証データにemailが含まれていればそれを元にユーザーを探す。
        #user = User.where(email: email).first if verified_email_from_oauth(auth)
        user = User.where(social_profiles: profile.uid)
        puts user.nil? 
        # 見つからなければ、ユーザーを新規作成。
        if user.nil? != true
         user = find_or_create_new_user(auth)
        else
         user ||= find_or_create_new_user(auth)
        end
      end
      associate_user_with_profile!(user, profile)
      user
    end

    private

      class << self

        def current_or_profile_user(profile)
          user = User.current_user.presence || profile.user
        end

        # 見つからなければ、ユーザーを新規作成。emailは後に確認するので今は仮のものを入れておく。
        # TEMP_EMAIL_PREFIXを手掛かりに後に仮のものかどうかの判別が可能。
        # OmniAuth認証時はパスワード入力は免除するので、ランダムのパスワードを入れておく。
        def find_or_create_new_user(auth)
          # Query for user if verified email is provided
          email = verified_email_from_oauth(auth)
          user = User.where(email: email).first
          if user.nil?
            temp_email = "#{User::TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
            if auth.provider == "twitter"
             user = User.new(
               user_name: auth.info.nickname,
               name: auth.info.nickname,
               email:    temp_email,
               user_image: auth.info.image,
               user_description: auth.info.description,
               #email:    email ? email : temp_email,
               password: Devise.friendly_token[0,20]
             )
            end
            if auth.provider == "facebook"
             user = User.new(
               user_name: auth.extra.raw_info.name,
               name: auth.extra.raw_info.id,
               email:    temp_email,
               user_image: auth.info.image,
               #email:    email ? email : temp_email,
               password: Devise.friendly_token[0,20]
             )
            end
            # email確認メール送信を延期するために一時的にemail確認済みの状態にする。
	    puts user.user_name
            #user.skip_confirmation!
    
            # email仮をデータベースに保存するため、validationを一時的に無効化。
            user.save(validate: false)
            user
          end
        end


        def verified_email_from_oauth(auth)
          auth.info.email if auth.info.email && (auth.info.verified || auth.info.verified_email)
        end

        # ユーザーとSocialProfileオブジェクトを関連づける。
        def associate_user_with_profile!(user, profile)
          profile.update!(user_id: user.id) if profile.user != user
        end
      end
    end
end
