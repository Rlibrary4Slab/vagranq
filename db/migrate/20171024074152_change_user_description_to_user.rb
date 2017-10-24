class ChangeUserDescriptionToUser < ActiveRecord::Migration
  def change 
    change_column :users, :user_description, :text
  end
end
