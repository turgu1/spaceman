class CreateMovingTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :moving_tasks do |t|
      t.string :name
      t.text :description
      t.references :specialty, index: true
      t.integer :responsability
      t.integer :order
      t.datetime :duration
      t.float :cost

      t.timestamps
    end
  end
end
