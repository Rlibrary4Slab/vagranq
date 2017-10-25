class Item < ActiveRecord::Base
 geocoded_by :address
 after_validation :geocode
 belongs_to :user, class_name: "User"
 has_many :item_likes, dependent: :destroy
 has_many :item_liked, class_name: "ItemLike", foreign_key: "item_id", dependent: :destroy
 validates :user_id, presence: true
 validates :description, presence: true
 validates :date, presence: true
 validates :price, presence: true
 paginates_per 21
 validates :category , exclusion: { in: %w(カテゴリを選択してください) ,message: "を入力してください"}
 enum category: {"カテゴリを選択してください":10 ,"スポット": 20, "イベント": 30}

 scope :spot, ->(category) {
        where(category: 20)
 }
 scope :event, ->(category){
        where(category: 30)
 }


end
