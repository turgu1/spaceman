class AddAllocationsCountToRequirements < ActiveRecord::Migration[5.1]
  def change
    add_column :requirements, :allocations_count, :integer
  end
end
