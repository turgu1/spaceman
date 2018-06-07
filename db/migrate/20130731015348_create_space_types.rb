class CreateSpaceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :space_types do |t|
      t.string :name
      t.integer :spaces_count, default: 0
      t.text :notes

      t.timestamps
    end
  end
end
