class CreateWings < ActiveRecord::Migration[5.1]
  def change
    create_table :wings do |t|
      t.references :building, index: true
      t.string :name
      t.binary :drawing
      t.string :drawing_filename
      t.string :drawing_type
      t.string :corners_coor
      t.float :gage_area
      t.string :gage_coor
      t.string :gage_center_coor
      t.integer :level
      t.integer :order
      t.integer :desk_min_area

      t.timestamps
    end
  end
end
