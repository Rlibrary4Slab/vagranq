class AddItemLikeIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :item_like_id, :integer
  end
end
