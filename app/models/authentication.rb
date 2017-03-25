class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :user_name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :token, presence: true

  def self.from_omniauth(auth, user)
    obj = find_or_initialize_by provider: auth.provider, uid: auth.uid
    obj.token = auth.credentials.token
    transaction do
      obj.user ||= user || User.create!(email: auth.info.email, password: Devise.friendly_token[0, 20])
      obj.save! if obj.changed?
    end
    obj
  end
end
