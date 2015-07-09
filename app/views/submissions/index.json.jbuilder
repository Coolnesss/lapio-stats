json.array!(@submissions) do |submission|
  json.extract! submission, :id, :week_id, :student_id, :points
  json.url submission_url(submission, format: :json)
end
