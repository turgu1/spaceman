class CreateSpaces < ActiveRecord::Migration[5.1]
  def change
    create_table :spaces do |t|
      t.references :wing, index: true
      t.string  :name
      t.string  :function
      t.string  :figure, length: 1
      t.string  :coor
      t.string  :center_coor
      t.float   :area
      t.integer :desk_count
      t.integer :order

      t.timestamps
    end
  end
end
