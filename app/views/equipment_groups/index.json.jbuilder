json.array!(@equipment_groups) do |equipment_group|
  json.extract! equipment_group, :name, :order, :parent_id
  json.url equipment_group_url(equipment_group, format: :json)
end
