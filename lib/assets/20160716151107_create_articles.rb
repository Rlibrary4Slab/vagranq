class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :category
      t.string :maintitle
      t.text :description
      t.string :titleon
      t.text :contento
      t.string :titletw
      t.text :contenttw
      t.string :titleth
      t.text :contentth
      t.string :username

      t.timestamps null: false
    end
     
  end
end
