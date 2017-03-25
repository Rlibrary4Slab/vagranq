class AddColumnToLike < ActiveRecord::Migration
  def change
    add_column :likes, :user_id, :integer
    add_column :likes, :article_id, :integer
  end
end
