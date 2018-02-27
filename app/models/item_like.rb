class ItemLike < ActiveRecord::Base
    belongs_to :item 

    #counter_culture :item, column_name: 'item_likes_count'
    #counter_culture :user, column_name: 'total_item_likes'
    #counter_culture :article
    scope :item_category, ->(category) { joins(:item).where("items.category = ?", category) }

    belongs_to :user, class_name: "User"
    #belongs_to :liked_user, class_name: "User"
    #has_many :notifications
    paginates_per 5
    validates :item_id, uniqueness:{ scope: [:user_id] }
end
