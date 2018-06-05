class AddConsumerToAllocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :allocations, :consumer, polymorphic: true, index: true

    #
    # As we are migrating allocations to polymorphism, t
    reversible do |dir|
      dir.up do
        Allocation.all.each do |a|
          unless a[:person_id].nil?
            puts("Person: #{a[:person_id]}")
            a.consumer_id = a[:person_id]
            a.consumer_type = 'Person'
          else
            puts("Requirement: #{a[:requirement_id]}")
            a.consumer_id = a[:requirement_id]
            a.consumer_type = 'Requirement'
          end
          a.save
        end
      end
    end
  end
end
