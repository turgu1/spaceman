class RemoveNoEnding < ActiveRecord::Migration[5.1]
  def up
    remove_column :allocations, :no_ending
    remove_column :people,      :no_ending
    remove_column :requests,    :no_ending
  end

  def down
    add_column :allocations, :no_ending, :boolean
    add_column :people,      :no_ending, :boolean
    add_column :requests,    :no_ending, :boolean
  end
end
