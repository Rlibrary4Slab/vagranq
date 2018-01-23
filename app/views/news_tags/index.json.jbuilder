json.array!(@news_tags) do |news_tag|
  json.extract! news_tag, :id, :title, :link
  json.url news_tag_url(news_tag, format: :json)
end
