class AddColumnsToWeekView < ActiveRecord::Migration
  def change
    add_column :week_views, :user_id, :integer
  end
end
