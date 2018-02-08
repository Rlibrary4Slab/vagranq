#class SocialProfile < ApplicationRecord
class SocialProfile < ActiveRecord::Base
  belongs_to :user
  store      :others

  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_oauth(auth)
    profile = find_or_create_by(uid: auth.uid, provider: auth.provider)
    profile.save_oauth_data!(auth)
    profile
  end
  def save_oauth_twi_data!(auth)

       self.update_attributes( uid:      auth["id_str"],
                            name:        auth["name"],
                            nickname:    auth["screen_name"],
                            url:         "https://twitter.com/#{auth["screen_name"]}",
                            image_url:   auth["profile_image_url"],
                            description: auth["description"],
                            credentials: auth["credentials"],
                            raw_info:    auth )
   end
 
   def save_oauth_face_data!(auth)

       self.update_attributes( uid:      auth["id"],
                            name:        auth["name"],
                            url:         auth["link"],
                            image_url:   "http://graph.facebook.com/v2.7/#{auth["id"]}/picture",
                            credentials: auth["credentials"],
                            raw_info:    auth )
   end

  def save_oauth_data!(auth)
    return unless valid_oauth?(auth)

    provider = auth["provider"]
    policy   = policy(provider, auth)

    self.update_attributes( uid:         policy.uid,
                            name:        policy.name,
                            nickname:    policy.nickname,
                            email:       policy.email,
                            url:         policy.url,
                            image_url:   policy.image_url,
                            description: policy.description,
                            credentials: policy.credentials,
                            raw_info:    policy.raw_info )
  end

  private

    def policy(provider, auth)
      class_name = "#{provider}".classify
      "OAuthPolicy::#{class_name}".constantize.new(auth)
    end

    def valid_oauth?(auth)
      (self.provider.to_s == auth['provider'].to_s) && (self.uid == auth['uid'])
    end
end
