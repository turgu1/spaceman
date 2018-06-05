class CreateEquipmentModels < ActiveRecord::Migration[5.1]
  def change
    create_table :equipment_models do |t|
      t.references :equipment_group, index: true
      t.string :name
      t.integer :order
      t.string :photo
      t.string :supplier
      t.string :model_ident
      t.decimal :price
      t.text :notes

      t.timestamps
    end
  end
end
