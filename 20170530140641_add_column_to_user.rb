class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_s, :boolean,:default => true
    add_column :users, :facebook_s, :boolean , :default => true
  end
end
