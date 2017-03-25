class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :category
      t.string :title #一覧タイトル
      t.text :description #一覧説明
      t.text :eyecatch_img
      t.integer :user_id
      t.string :aasm_state
      

      t.timestamps null: false
    end
  end
end
