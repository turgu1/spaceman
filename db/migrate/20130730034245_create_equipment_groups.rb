class CreateEquipmentGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_groups do |t|
      t.string :name
      t.integer :order
      t.references :parent, index: true

      t.timestamps
    end
  end
end
