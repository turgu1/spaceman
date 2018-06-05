class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.references :org, index: true
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :phone_number
      t.boolean :needs_office_space
      t.date :from_date
      t.date :to_date
      t.boolean :no_ending

      t.timestamps
    end
  end
end
