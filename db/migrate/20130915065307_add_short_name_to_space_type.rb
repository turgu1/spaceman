class AddShortNameToSpaceType < ActiveRecord::Migration[5.1]
  def change
    add_column :space_types, :short_name, :string
  end
end
