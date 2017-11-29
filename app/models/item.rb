class Item < ActiveRecord::Base
 acts_as_taggable
 geocoded_by :address
 after_validation :geocode
 belongs_to :user, class_name: "User"
 belongs_to :article
 has_many :item_likes, dependent: :destroy
 has_many :item_spots, dependent: :destroy
 has_many :item_liked, class_name: "ItemLike", foreign_key: "item_id", dependent: :destroy
 validates :user_id, presence: true
 validates :title, presence: true,uniqueness: {case_sensitive:false}
 #validates :description, presence: true
 has_many :item_days
 mount_uploader :image, ItemImageUploader
 accepts_nested_attributes_for :item_days, allow_destroy: true, reject_if: :all_blank
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
