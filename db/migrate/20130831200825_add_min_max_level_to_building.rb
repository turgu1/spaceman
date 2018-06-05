class AddMinMaxLevelToBuilding < ActiveRecord::Migration[5.1]
  def change
    add_column :buildings, :min_level, :integer
    add_column :buildings, :max_level, :integer
  end
end
