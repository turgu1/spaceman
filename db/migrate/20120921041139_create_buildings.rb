class CreateBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :short_name
      t.string :photo_filename
      t.string :photo_type
      t.binary :photo

      t.timestamps
    end
  end
end
