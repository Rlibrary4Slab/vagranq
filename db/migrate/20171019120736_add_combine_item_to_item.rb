class AddCombineItemToItem < ActiveRecord::Migration
  def change
    add_column :items, :combine, :integer
  end
end
