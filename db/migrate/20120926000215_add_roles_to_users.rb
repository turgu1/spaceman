class AddRolesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role_admin,       :boolean
    add_column :users, :role_pilot,       :boolean
    add_column :users, :role_building,    :boolean
    add_column :users, :role_org,         :boolean
    add_column :users, :role_allocation,  :boolean
    add_column :users, :role_request,     :boolean

    add_column :users, :buildings_to_man, :string
    add_column :users, :orgs_to_man,      :string
  end
end
