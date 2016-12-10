class Article < ActiveRecord::Base
    include AASM
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liking_users, through: :likes, source: :user
    is_impressionable
    #validates :title, presence: true
    #validates :description,presence: true
    validates :user_id, presence: true
    #validates :category , exclusion: { in: %w(カテゴリを選択してください) ,message: "カテゴリが選択されていません"} ,presence: true 
    
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
    enum category: {"カテゴリを選択してください":10 ,"ファッション": 20, "ビューティー": 30, "ライフスタイル": 40,"グルメ": 50, "おでかけ": 60,"エンタメ": 70, "学び": 80,"アイテム": 90, "おもしろ": 100, "その他": 110} 
    
    scope :get_by_category, ->(category) {
        where(category: category)
    }
        
    scope :get_by_description, ->(description){
        where("description like?","%#{description}%")
    }
    scope :get_by_title, ->(title){
        where("title like?","%#{title}%")
    }
   
end
