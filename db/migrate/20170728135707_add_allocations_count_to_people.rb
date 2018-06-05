class AddAllocationsCountToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :allocations_count, :integer
  end
end
