json.array!(@weeks) do |week|
  json.extract! week, :id, :name, :max_points
  json.url week_url(week, format: :json)
end
