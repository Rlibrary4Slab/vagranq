class AddArticeIdToNewsCrawler < ActiveRecord::Migration
  def change
    add_column :news_crawlers, :article_id, :integer
    add_column :users, :exclusion, :boolean, :default => false
  end
end
