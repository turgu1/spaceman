class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :group
      t.integer :order
      t.string :icon
      t.text :params_script
      t.text :exec_script
      t.text :view_script

      t.timestamps
    end
  end
end
