json.array!(@equipment_models) do |equipment_model|
  json.extract! equipment_model, :name, :photo, :photo_filename, :photo_type, :supplier, :price, :notes
  json.url equipment_model_url(equipment_model, format: :json)
end
