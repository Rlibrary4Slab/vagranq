class NewsTag < ActiveRecord::Base
 #validates :title, uniqueness: true ,presence: true
 validates :link,uniqueness: true,presence: true 
 
end
