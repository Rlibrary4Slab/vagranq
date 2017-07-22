class AddDayCountViewToUser < ActiveRecord::Migration
  def change
    add_column :users, :day_count_view, :integer   
  end
end
