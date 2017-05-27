class AddColumnToLike < ActiveRecord::Migration
  def change
    add_column :likes, :liked_user_id, :integer
  end
end
