class AddArticleIdToItemLikes < ActiveRecord::Migration
  def change
    add_column :item_likes, :article_id, :integer
  end
end
