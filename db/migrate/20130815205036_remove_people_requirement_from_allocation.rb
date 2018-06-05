class RemovePeopleRequirementFromAllocation < ActiveRecord::Migration[5.1]
  def up
    remove_column :allocations, :person_id
    remove_column :allocations, :requirement_id
  end

  def down
    add_column :allocations, :person, :references
    add_column :allocations, :requirement, :references
    add_index :allocations, :request_id
    add_index :allocations, :person_id

    Allocation.all.each do |a|
      if a.consumer_type == 'Person'
        a.person_id = a.consumer_id
      else
        a.requirement_id = a.consumer_id
      end
      a.save
    end

  end
end
