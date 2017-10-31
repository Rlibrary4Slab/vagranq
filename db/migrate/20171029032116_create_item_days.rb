class CreateItemDays < ActiveRecord::Migration
  def change
    create_table :item_days do |t|
      t.integer :item_id
      t.boolean :mon, :default => false
      t.boolean :tue, :default => false 
      t.boolean :wed, :default => false
      t.boolean :thu, :default => false
      t.boolean :fri, :default => false
      t.boolean :sat, :default => false
      t.boolean :sun, :default => false
      t.boolean :hol, :default => false
      t.datetime :begin_time
      t.datetime :finish_time
      t.datetime :begin_day
      t.datetime :finish_day

      t.timestamps null: false
    end
    remove_column :items, :week, :string
    add_column :items, :item_days_id ,:integer
    
  end
end
