class CreateEquipmentItems < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_items do |t|
      t.integer :qty
      t.references :itemable, polymorphic: true, index: true
      t.references :equipment_model, index: true
      t.text :notes

      t.timestamps
    end
  end
end
