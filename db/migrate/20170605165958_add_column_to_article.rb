class AddColumnToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :view_count, :integer
  end
ends