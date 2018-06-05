json.array!(@space_types) do |space_type|
  json.extract! space_type, :name, :space_count, :notes
  json.url space_type_url(space_type, format: :json)
end
