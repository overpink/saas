json.array!(@projects) do |project|
  json.extract! project, :id, :tenant_id, :name, :description, :slug
  json.url project_url(project, format: :json)
end
