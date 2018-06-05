json.array!(@equipment_items) do |equipment_item|
  json.extract! equipment_item, :qty, :itemable_id, :itemable_type, :equipment_model_id
  json.url equipment_item_url(equipment_item, format: :json)
end
