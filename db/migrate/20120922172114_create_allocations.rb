class CreateAllocations < ActiveRecord::Migration[5.1]
  def change
    create_table :allocations do |t|
      t.references :space, index: true
      t.references :request, index: true # --> requests eventually...
      t.references :person, index: true
      t.date :from_date
      t.date :to_date
      t.boolean :no_ending
      t.integer :desk_count
      t.integer :area
      t.integer :allocated_by_id  # --> users eventually...
      t.date :date
      t.text :notes

      t.timestamps
    end
    add_index :allocations, :from_date
    add_index :allocations, :to_date
  end
end
