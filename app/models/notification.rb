class Notification < ActiveRecord::Base
    belongs_to :user
    belongs_to :like
    belongs_to :article
    paginates_per 5
    
    validates :article_id, :uniqueness => { :scope => [:content, :category] }
    validates :article_id, uniqueness: {:scope => :user_id}, if: "category == 1"
end
