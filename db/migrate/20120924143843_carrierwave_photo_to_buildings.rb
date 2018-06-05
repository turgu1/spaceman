# encoding: utf-8

class CarrierwavePhotoToBuildings < ActiveRecord::Migration[5.1]
  def up
    change_table :buildings do |t|
      t.remove :photo, :photo_type, :photo_filename
      t.string :photo
    end
  end

  def down
    change_table :buildings do |t|
      t.remove :photo
      t.string :photo_filename
      t.string :photo_type
      t.binary :photo
    end
  end
end
