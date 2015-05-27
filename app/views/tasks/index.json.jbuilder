json.array!(@tasks) do |task|
  json.extract! task, :id, :project_id, :content, :status, :user_id, :author_id
  json.url task_url(task, format: :json)
end
