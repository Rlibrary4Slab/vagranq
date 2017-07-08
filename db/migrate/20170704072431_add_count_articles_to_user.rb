class AddCountArticlesToUser < ActiveRecord::Migration
  def change
   add_column :users, :count_articles, :integer 
   add_column :users, :all_articles_views, :integer 
  end
end
