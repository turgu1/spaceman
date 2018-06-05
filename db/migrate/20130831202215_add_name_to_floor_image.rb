class AddNameToFloorImage < ActiveRecord::Migration[5.1]
  def change
    add_column :floor_images, :name, :string
  end
end
