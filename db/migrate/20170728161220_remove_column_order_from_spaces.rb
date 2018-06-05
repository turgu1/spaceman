class RemoveColumnOrderFromSpaces < ActiveRecord::Migration[5.1]
  def up
    remove_column(:spaces, :order)
  end
  def down
  	add_column(:spaces, :order, :integer)
  end
end
