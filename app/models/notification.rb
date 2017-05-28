class Notification < ActiveRecord::Base
    belongs_to :user
    belongs_to :like
    belongs_to :article
    paginates_per 5
    
    validates :article_id, :uniqueness => { :scope => [:content, :category] }

end
