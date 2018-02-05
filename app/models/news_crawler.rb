class NewsCrawler < ActiveRecord::Base
  validates :title, uniqueness: true
end
