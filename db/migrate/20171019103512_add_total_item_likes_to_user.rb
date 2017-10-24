class AddTotalItemLikesToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_item_likes, :integer
  end
end
