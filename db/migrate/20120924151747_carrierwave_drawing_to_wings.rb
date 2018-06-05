class CarrierwaveDrawingToWings < ActiveRecord::Migration[5.1]
  def up
    change_table :wings do |t|
      t.remove :drawing, :drawing_type, :drawing_filename
      t.string :drawing
    end
  end

  def down
    change_table :wings do |t|
      t.remove :drawing
      t.string :drawing_filename
      t.string :drawing_type
      t.binary :drawing
    end
  end
end
