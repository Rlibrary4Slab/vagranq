class Article < ActiveRecord::Base
    include AASM
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liking_users, through: :likes, source: :user
    is_impressionable
    validates :title, length: { maximum: 30, message: "が長すぎます30文字以下にしてください"} 
    validates_presence_of :title,message: "を入力してください"
    validates_presence_of :eyecatch_img ,message: "が認識できませんでした"
    #validates :description,presence: true
    validates :user_id, presence: true
    
    validates :category , exclusion: { in: %w(カテゴリを選択してください) ,message: "を入力してください"}
    
    has_many :contents
    paginates_per 4
    accepts_nested_attributes_for :contents, allow_destroy: true, reject_if: :all_blank
    aasm do
        state :draft, :initial => true
        state :published 
        state :topconed
        
        event :intop,  before: ->{ self.published_at = Time.now } do
            transitions :from => :draft, :to => :published
            transitions :from => :published, :to => :draft

        end
        event :publish, before: ->{ self.published_at = Time.now } do
            transitions :from => :draft, :to => :published
        end

        event :draft do
            transitions :from => :published, :to => :draft
        end
    end
    enum category: {"カテゴリを選択してください":10 ,"ファッション": 20, "美容健康": 30, "おでかけ": 40,"グルメ": 50, "ライフスタイル": 60,"エンタメ": 70, "インテリア": 80, "ガジェット":90,"学び": 100, "おもしろ": 110} 
    
    scope :fashion, ->(category) {
        where(category: 20)
    }
    scope :beauty, ->(category){
        where(category: 30)
    }
    scope :hangout, ->(category){
        where(category: 40)
    }
    scope :gourmet, ->(category){
        where(category: 50)
    }
    scope :lifestyle, ->(category){
        where(category: 60)
    }
    scope :entertainment, ->(category){
        where(category: 70)
    }
    scope :interior, ->(category){
        where(category: 80)
    }
    scope :gadget, ->(category){
        where(category: 90)
    }
    scope :learn, ->(category){
        where(category: 100)
    }
    scope :funny, ->(category){
        where(category: 110)
    }
    scope :get_by_description, ->(description){
        where("description like?","%#{description}%")
    }
    scope :get_by_title, ->(title){
        where("title like?","%#{title}%")
    }
   
end
