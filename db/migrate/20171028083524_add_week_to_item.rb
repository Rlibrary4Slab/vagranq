class AddWeekToItem < ActiveRecord::Migration
  def change
    add_column :items, :week, :string
  end
end
