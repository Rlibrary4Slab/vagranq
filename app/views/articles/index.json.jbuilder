json.array!(@articles) do |article|
  json.extract! article, :id, :category, :title, :description, :content, :user_id
  json.url article_url(article, format: :json)
end
