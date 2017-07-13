class AddPeriodViewArticleToUser < ActiveRecord::Migration
  def change
   add_column :users, :period_count_articles, :integer
   add_column :users, :period_articles_views, :integer
  end
end
