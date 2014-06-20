json.array!(@posts) do |post|
  json.extract! post, :id, :name, :url, :username, :votes
  json.url post_url(post, format: :json)
end
