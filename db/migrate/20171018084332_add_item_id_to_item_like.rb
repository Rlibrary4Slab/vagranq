class AddItemIdToItemLike < ActiveRecord::Migration
  def change
   
   remove_column :likes, :item_id,:integer
   
  end
end
