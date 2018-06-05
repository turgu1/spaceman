class CreateFieldDefs < ActiveRecord::Migration[5.1]
  def change
    create_table :field_defs do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.integer :order
      t.belongs_to :table_def, index: true

      t.timestamps
    end
  end
end
