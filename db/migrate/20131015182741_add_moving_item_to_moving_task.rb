class AddMovingItemToMovingTask < ActiveRecord::Migration[5.1]
  def change
    add_reference :moving_tasks, :moving_item, index: true
  end
end
