class AddLocatorCoorToFloor < ActiveRecord::Migration[5.1]
  def change
    add_column :floors, :locator_coor, :string
  end
end
