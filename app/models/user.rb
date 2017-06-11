class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         omniauth_providers: [:twitter,:facebook]
    has_many :social_profiles, dependent: :destroy
    has_many :authentication, dependent: :destroy
    attr_accessor :crop_x , :crop_y, :crop_w, :crop_h ,:username,:remember_token,:twi,:face
    has_many :articles, dependent: :destroy
    has_many :likes
    has_many :notifications, foreign_key: "user_id", dependent: :destroy
    #has_many :likes, dependent: :destroy
    has_many :like_articles, through: :likes, source: :article
    before_save {self.email =email.downcase}
    #validates :name, presence: true, length: {maximum: 50},uniqueness: {case_sensitive:false}, format: { with: /\A[a-z0-9]+\z/i, message: "英数字入力してください" } 
    validates :name, presence: true,length: {maximum: 50},uniqueness: {case_sensitive:false},on: :create
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i
    validates :email, presence: true,  length: {maximum:255},uniqueness: {case_sensitive:false},on: :create,format: {with: VALID_EMAIL_REGEX, message: "メールアドレスを入力してください"}
    validates :password, presence: true, on: :create,length: {minimum:6,message: "6桁以上入力してください"}
    #has_secure_password
    mount_uploader :user_image,ImageUploader
    mount_uploader :header_image,ImageUploader
    after_update :crop_image
    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/
    
    #is_impressionable
    paginates_per 20 
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

    def reset_confirmation!
     self.update_column(:confirmed_at, nil)
    end

    # Userモデル経由でcurrent_userを参照できるようにする。
    def self.current_user=(user)
     # Set current user in Thread.
     Thread.current[:current_user] = user
    end

    # Userモデル経由でcurrent_userを参照する。
    def self.current_user
     # Get current user from Thread.
     Thread.current[:current_user]
    end







    def social_profile(provider)
     social_profiles.select{ |sp| sp.provider == provider.to_s }.first
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
         user.user_image = auth.info.image
         user.user_description = auth.info.description
        end
        if auth.provider == "facebook"
         user.user_name = auth.extra.raw_info.name
         user.name = auth.extra.raw_info.id
         user.user_image = auth.info.image
        end
	user.password = auth.provider+auth.uid
        user.email = User.dummy_email(auth)
        user.admin = true
        puts user.attributes
        puts "jan"  

      end

    end
 
    def self.frome_omniauth(auth)
     user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
     user.attributes = {
      
      password: Devise.friendly_token[0, 20],
      name: auth.info.nickname, # assuming the user model has a name
      user_name: auth.info.nickname # assuming the user model has an image
     }
     user.save if user.changed?
     user
    end    

    def self.create_with_omniauth(auth)
     create do |user| 
      user.provider = auth.provider 
      user.uid = auth.uid
      user.user_name = auth.info.nickname
      user.name = auth.info.nickname
      user.admin = true
      user.password = auth.uid 
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
