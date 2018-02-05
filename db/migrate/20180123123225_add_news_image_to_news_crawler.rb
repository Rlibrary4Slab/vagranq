class AddNewsImageToNewsCrawler < ActiveRecord::Migration
  def change
    add_column :news_crawlers, :news_image, :text
  end
end
