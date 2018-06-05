class CreateOrgs < ActiveRecord::Migration[5.1]
  def change
    create_table :orgs do |t|
      t.string :name
      t.string :abbreviation
      t.integer :order
      t.references :manager, index: true
      t.references :parent, index: true
      t.references :admin, index: true

      t.timestamps
    end
  end
end
