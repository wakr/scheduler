json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :name, :user_id, :is_done, :deadline
  json.url assignment_url(assignment, format: :json)
end
