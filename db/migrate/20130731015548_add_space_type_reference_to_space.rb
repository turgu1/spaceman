class AddSpaceTypeReferenceToSpace < ActiveRecord::Migration[5.1]
  def change
    add_reference :spaces, :space_type, index: true
  end
end
