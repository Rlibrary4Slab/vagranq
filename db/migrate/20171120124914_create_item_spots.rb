class CreateItemSpots < ActiveRecord::Migration
  def change
    create_table :item_spots do |t|
      t.integer :event_id
      t.integer :spot_id

      t.timestamps null: false
    end
  end
end
