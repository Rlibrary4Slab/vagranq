class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.string :category
      t.datetime :date
      t.integer :price
      t.integer :user_id
      t.integer :article_id
      t.integer :like_id

      t.timestamps null: false
    end
  end
end
