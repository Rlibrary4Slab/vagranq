class AddImageToItem < ActiveRecord::Migration
  def change
    add_column :items, :image, :text
    remove_column :items, :images 
  end
end
