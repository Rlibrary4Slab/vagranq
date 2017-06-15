class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :article_id
      t.integer :category
      t.integer :content
      t.boolean :flag

      t.timestamps null: false
    end
  end
end
