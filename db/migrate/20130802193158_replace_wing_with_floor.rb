class ReplaceWingWithFloor < ActiveRecord::Migration[5.1]
  def change
    rename_column :spaces, :wing_id, :floor_id
    rename_table :wings, :floors
  end
end
