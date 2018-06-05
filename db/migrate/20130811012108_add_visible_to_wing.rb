class AddVisibleToWing < ActiveRecord::Migration[5.1]
  def change
    add_column :wings, :visible, :boolean, :default => true
  end
end
