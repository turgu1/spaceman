class CreateFloorImages < ActiveRecord::Migration[5.1]
  def change
    create_table :floor_images do |t|
      t.integer :level
      t.belongs_to :building, index: true
      t.string :file

      t.timestamps
    end
  end
end
