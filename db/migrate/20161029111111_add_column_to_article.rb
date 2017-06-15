class AddColumnToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :likes_count, :integer
    add_column :articles, :published_at, :datetime
    add_column :articles, :corporecom, :integer
    add_column :articles, :checkagree, :boolean , default: false, null: false
    add_column :articles, :view_count, :integer
  end
end
