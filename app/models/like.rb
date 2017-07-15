class Like < ActiveRecord::Base
    belongs_to :article
    
    counter_culture :article, column_name: 'likes_count'
    counter_culture :user, column_name: 'total_likes'


    belongs_to :user, class_name: "User"
    belongs_to :liked_user, class_name: "User"
    has_many :notifications
    paginates_per 5
    validates :article_id, uniqueness:{ scope: [:user_id] }
end
