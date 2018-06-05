json.array!(@wings) do |wing|
  json.extract! wing, :name, :short_name, :floors_count, :building_id
  json.url wing_url(wing, format: :json)
end
