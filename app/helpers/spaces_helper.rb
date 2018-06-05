module SpacesHelper

  # Build a consolidated list of equipments from a space object, considering:
  # - Equipments defined at the space_type
  # - Equipments defined at the space
  # - Equipments defined at the allocations
  # It is build as follow:
  #
  # list = { id => [qty, photo_url, last_update_datetime]}
  def equipment_list(space)

    def add_item_to_list(list, item)
      id = item.equipment_model_id
      list[id] ||= [0, nil, nil]
      list[id][0] += item.qty
      list[id][1] ||= item.try(:photo).try(:thumb).try(:url)
      list[id][2] ||= item.updated_at.to_f
      list[id][3] ||= item.equipment_model.name
    end

    list = {}

    space.space_type.equipment_items.each { |item| add_item_to_list(list, item) } unless space.space_type.nil?
    space.equipment_items.each { |item| add_item_to_list(list, item) }
    space.allocations.each do |alloc|
      alloc.equipment_items.each { |item| add_item_to_list(list, item) }
    end

    list
  end
end
