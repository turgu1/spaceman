class ModifyRolesManagementInUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :role_admin
    remove_column :users, :role_pilot
    remove_column :users, :role_building
    remove_column :users, :role_org
    remove_column :users, :role_allocation
    remove_column :users, :role_request

    add_column :users, :roles, :string, array: true, default: []
  end

  def down
    add_column :users, :role_admin,       :boolean
    add_column :users, :role_pilot,       :boolean
    add_column :users, :role_building,    :boolean
    add_column :users, :role_org,         :boolean
    add_column :users, :role_allocation,  :boolean
    add_column :users, :role_request,     :boolean
  end
end
