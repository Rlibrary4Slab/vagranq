class CreateNewsCrawlersAddArticleTitleDescriptionToNewsTag < ActiveRecord::Migration
  def change
    create_table :news_crawlers do |t|
      t.string :title
      t.text :news_link
      t.text :news_body

      t.timestamps null: false
    end
    add_column :news_tags,:article_title,:string
    add_column :news_tags,:article_description,:text
  end
end
