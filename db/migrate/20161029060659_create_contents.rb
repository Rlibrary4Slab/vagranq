class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title #記事タイトルネスト
      t.text :description #記事本文ネスト
      t.integer :article_id
      t.string :position
      t.timestamps null: false
    end
  end
end
