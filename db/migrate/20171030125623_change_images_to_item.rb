class ChangeImagesToItem < ActiveRecord::Migration
  def change
   change_column :items, :images,:text, array: true
  end
end
