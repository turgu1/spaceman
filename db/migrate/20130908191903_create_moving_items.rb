class CreateMovingItems < ActiveRecord::Migration[5.1]
  def change
    create_table :moving_items do |t|
      t.references :allocation, index: true
      t.float :weight
      t.float :volume
      t.text :notes
      t.references :destination, index: true
      t.references :replace, index: true
      t.string :description
      t.integer :qty

      t.timestamps
    end
  end
end
