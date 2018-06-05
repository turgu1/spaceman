json.array!(@moving_items) do |moving_item|
  json.extract! moving_item, :allocation_id, :weight, :volume, :notes, :destination_id, :replace_id, :description, :qty
  json.url moving_item_url(moving_item, format: :json)
end
