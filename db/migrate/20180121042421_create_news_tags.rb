class CreateNewsTags < ActiveRecord::Migration
  def change
    create_table :news_tags do |t|
      t.string :title
      t.integer :link

      t.timestamps null: false
    end
  end
end
