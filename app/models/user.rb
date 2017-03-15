class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:twitter,:facebook]
    has_many :social_profiles, dependent: :destroy
    has_many :authentication, dependent: :destroy
    def social_profile(provider)
     social_profiles.select{ |sp| sp.provider == provider.to_s }.first
    end 
    attr_accessor :crop_x , :crop_y, :crop_w, :crop_h ,:username
    #has_many :microposts, dependent: :destroy
    has_many :articles, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :like_articles, through: :likes, source: :article
    #validates_uniqueness_of :name
    #validates_presence_of :name
    attr_accessor :remember_token
    before_save {self.email =email.downcase}
    validates :name, presence: true, length: {maximum: 50},uniqueness: {case_sensitive:false}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i
    validates :email, presence: true, length: {maximum:255},uniqueness: {case_sensitive:false},format: {with: VALID_EMAIL_REGEX}
    #has_secure_password
    #validates :password, presence: true, length: {minimum:6}
    mount_uploader :user_image,ImageUploader
    mount_uploader :header_image,ImageUploader
    after_update :crop_image
    
    #is_impressionable
    paginates_per 5
    def to_param
     name
   
    end
  
    def cropping?
        crop_x && crop_y && crop_w && crop_h
    end
    
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    def remember
       self.remember_token = User.new_token
       update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    def authenticated?(remember_token)
       BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def forget
        return false if remember_digest.nil?
        update_attribute(:remember_digest, nil)
    end
    
    
    def self.create_unique_string
      SecureRandom.uuid
    end
    
    def self.from_omniauth(auth)
      #where(auth.slice(:provider, :uid)).first_or_create do |user|
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        #user = User.where('email =?', auth.info.email).first
        #if user.blank?
        #  user = User.new
        #end
        user.provider = auth.provider
        user.uid = auth.uid
        if auth.provider == "twitter"
         user.user_name = auth.info.nickname
         user.name = auth.info.nickname
        end
        if auth.provider == "facebook"
         user.user_name = auth.extra.raw_info.name
         user.name = auth.extra.raw_info.id
        end
        user.email = User.dummy_email(auth)
        user    
      end

    end
 
    def self.new_with_session(params, session)
     if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
     else
      super
     end
    end
    
    def password_required?
     super && provider.blank?  # provider属性に値があればパスワード入力免除
    end

  # Edit時、OmniAuthで認証したユーザーのパスワード入力免除するため、Deviseの実装をOverrideする。
    def update_with_password(params, *options)
     if encrypted_password.blank?            # encrypted_password属性が空の場合
      update_attributes(params, *options)   # パスワード入力なしにデータ更新
     else
      super
     end
    end 
   private


    def self.dummy_email(auth)
     "#{auth.uid}-#{auth.provider}@example.com"
    end 

    def crop_image
        user_image.recreate_versions! if user_image.present? && crop_x.present?   
        
    end
    
    
end
