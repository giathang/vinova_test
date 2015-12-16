json.array!(@posts) do |post|
  json.extract! post, :id, :category_id, :point, :title, :image_url
  json.url post_url(post, format: :json)
end
