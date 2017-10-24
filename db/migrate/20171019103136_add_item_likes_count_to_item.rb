class AddItemLikesCountToItem < ActiveRecord::Migration
  def change
    add_column :items, :item_likes_count, :integer
  end
end
