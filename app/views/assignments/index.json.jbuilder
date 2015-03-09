json.array!(@assignments) do |assignment|
  json.extract! assignment, :id
  json.title assignment.name
  json.start assignment.created_at
  json.end assignment.deadline
  json.url assignment_url(assignment)
end
