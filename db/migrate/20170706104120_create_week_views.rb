class CreateWeekViews < ActiveRecord::Migration
  def change
    create_table :week_views do |t|
      t.integer :user_id
      t.integer :day0
      t.integer :day1
      t.integer :day2
      t.integer :day3
      t.integer :day4
      t.integer :day5
      t.integer :day6

      t.timestamps null: false
    end
  end
end
