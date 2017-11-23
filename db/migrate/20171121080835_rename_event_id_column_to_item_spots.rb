class RenameEventIdColumnToItemSpots < ActiveRecord::Migration
  def change
    rename_column :item_spots,:event_id,:item_id
  end
end
