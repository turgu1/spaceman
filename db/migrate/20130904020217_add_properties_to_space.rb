class AddPropertiesToSpace < ActiveRecord::Migration[5.1]
  def up
    add_column :spaces, :properties, :hstore, default: {}
  end

  def down
    remove_column :spaces, :properties
  end
end
