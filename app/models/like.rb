class Like < ActiveRecord::Base
    belongs_to :article  
    belongs_to :user, class_name: "User"
    belongs_to :liked_user, class_name: "User"
    has_many :notifications
    
    counter_culture :article, column_name: 'likes_count'
    counter_culture :user, column_name: 'total_likes'
    scope :article_published, -> { joins(:article).where("articles.aasm_state = ? " , "published") }

    paginates_per 5
    validates :article_id, uniqueness:{ scope: [:user_id] }
end
