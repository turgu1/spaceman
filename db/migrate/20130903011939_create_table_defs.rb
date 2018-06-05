class CreateTableDefs < ActiveRecord::Migration[5.1]
  def change
    create_table :table_defs do |t|
      t.string :name

      t.timestamps
    end
  end
end
