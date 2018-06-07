class ManageListsToArrays < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :buildings_to_man
    remove_column :users, :orgs_to_man
    add_column :users, :buildings_to_man, :integer, array: true, default: []
    add_column :users, :orgs_to_man,      :integer, array: true, default: []
    add_column :users, :man_all_org,      :boolean, default: false
    add_column :users, :man_all_building, :boolean, default: false
  end

  def down
    remove_column :users, :buildings_to_man
    remove_column :users, :orgs_to_man
    remove_column :users, :man_all_org
    remove_column :users, :man_all_building
    add_column :users, :buildings_to_man, :string
    add_column :users, :orgs_to_man,      :string
  end
end
