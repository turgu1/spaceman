class AddAllocateEquipmentAndMovingItemsToBuilding < ActiveRecord::Migration[5.1]
  def change
    add_column :buildings, :allocate_equipment, :boolean, default: true
    add_column :buildings, :moving_items, :boolean, default: false
  end
end
