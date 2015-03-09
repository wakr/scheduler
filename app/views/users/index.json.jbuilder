json.array!(@users) do |user|
  json.extract! user, :id, :name, :birthdate
  json.url user_url(user, format: :json)
end
