class AddUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_id, :string ,null: false, default: ""
    add_column :users, :user_name, :string
    add_column :users, :user_description, :string
    add_column :users, :user_image, :string
    add_column :users, :header_image, :string
    
    add_index :users, :user_id, unique: true
  end
end
