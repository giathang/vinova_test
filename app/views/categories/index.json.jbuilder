json.array!(@categories) do |category|
  json.extract! category, :id, :name, :is_crawl
  json.url category_url(category, format: :json)
end
