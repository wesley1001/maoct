json.array!(@meetups) do |meetup|
  json.extract! meetup, :id, :title, :open_at, :close_at, :deadline, :place, :intro, :author_id
  json.url meetup_url(meetup, format: :json)
end
