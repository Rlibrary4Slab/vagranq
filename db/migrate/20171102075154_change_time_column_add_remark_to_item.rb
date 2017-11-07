class ChangeTimeColumnAddRemarkToItem < ActiveRecord::Migration
  def change
    add_column :items,:remark,:text
    change_column :item_days, :begin_time,:time
    change_column :item_days, :finish_time,:time
  end
end
