json.array!(@specialties) do |specialty|
  json.extract! specialty, :name
  json.url specialty_url(specialty, format: :json)
end
