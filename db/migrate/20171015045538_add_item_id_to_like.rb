class AddItemIdToLike < ActiveRecord::Migration
  def change
  	add_column :likes, :item_id,:integer

  end
end
