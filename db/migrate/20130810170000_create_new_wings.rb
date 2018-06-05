class CreateNewWings < ActiveRecord::Migration[5.1]
  def change
    create_table :wings do |t|
      t.references :building, index: true
      t.string :name
      t.string :short_name
      t.integer :order
      t.integer :floors_count, :default => 0

      t.timestamps
    end
  end
end