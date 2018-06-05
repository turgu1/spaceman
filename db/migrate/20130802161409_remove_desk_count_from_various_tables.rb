class RemoveDeskCountFromVariousTables < ActiveRecord::Migration[5.1]
  def up
    remove_column :spaces,      :desk_count
    remove_column :allocations, :desk_count
    remove_column :requests,    :desk_count
    remove_column :requests,    :desk_count_adjusted
  end
  def down
    add_column :spaces,      :desk_count,          :integer
    add_column :allocations, :desk_count,          :integer
    add_column :requests,    :desk_count,          :integer
    add_column :requests,    :desk_count_adjusted, :integer
  end
end
