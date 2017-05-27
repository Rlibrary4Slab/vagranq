class Like < ActiveRecord::Base
    belongs_to :article, counter_cache: :likes_count
    belongs_to :user, class_name: "User"
    belongs_to :liked_user, class_name: "User"
    has_many :notifications, foreign_key: "content"
    paginates_per 5
    validates :article_id, uniqueness:{ scope: [:user_id] }
    
end
