json.array!(@weeks) do |week|
  json.extract! week, :id, :name
  json.url week_url(week, format: :json)
end
