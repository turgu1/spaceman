class CacheAllocationsCount < ActiveRecord::Migration[5.1]
  def up
    execute "update people set allocations_count=(select count(*) from allocations where consumer_type='Person' and consumer_id=people.id)"
    execute "update requirements set allocations_count=(select count(*) from allocations where consumer_type='Requirement' and consumer_id=requirements.id)"
  end
  def down
  end
end
