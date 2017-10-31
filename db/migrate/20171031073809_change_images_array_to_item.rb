class ChangeImagesArrayToItem < ActiveRecord::Migration
  def change
   change_column :items, :images,:text, array: false
  end
end

