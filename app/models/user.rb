class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
    attr_accessor :crop_x , :crop_y, :crop_w, :crop_h
    #has_many :microposts, dependent: :destroy
    has_many :articles, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :like_articles, through: :likes, source: :article
    validates_uniqueness_of :name
    validates_presence_of :name
    attr_accessor :remember_token
    before_save {self.email =email.downcase}
    validates :name, presence: true, length: {maximum: 50},uniqueness: {case_sensitive:false}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i
    validates :email, presence: true, length: {maximum:255},
               uniqueness: {case_sensitive:false},
              format: {with: VALID_EMAIL_REGEX}
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
    
    private
    
    def crop_image
        user_image.recreate_versions! if user_image.present? && crop_x.present?   
        
    end
end
