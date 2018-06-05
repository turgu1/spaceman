class RemoveAreaFromVariousTables < ActiveRecord::Migration[5.1]
  def up
    remove_column :wings,       :desk_min_area
    remove_column :allocations, :area
    remove_column :requests,    :area
    remove_column :requests,    :area_adjusted
  end
  def down
    add_column :wings,       :desk_min_area, :float
    add_column :allocations, :area,          :float
    add_column :requests,    :area,          :float
    add_column :requests,    :area_adjusted, :float
  end
end
