class Notification < ActiveRecord::Base
    belongs_to :user
    belongs_to :like
    belongs_to :article
    paginates_per 5
    
    validates :article_id, :uniqueness => { :scope => [:content, :category] }
    # validates :user_id, if: "category == 1", uniqueness: {:scope => :article_id}
 
end
