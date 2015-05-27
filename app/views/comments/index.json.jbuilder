json.array!(@comments) do |comment|
  json.extract! comment, :id, :owner_type, :owner_id, :content, :author_id
  json.url comment_url(comment, format: :json)
end
