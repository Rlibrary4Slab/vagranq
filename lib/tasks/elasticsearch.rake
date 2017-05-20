namespace :elasticsearch do
  desc 'Elasticsearch のindex作成'
  task :create_index => :environment do
    Article.create_index!
    Article.import
    #Content.create_index!
  end
  desc 'Article を Elasticsearch に登録'
  task :import_article => :environment do
    #Article.import
    #Content.import
  end
end
