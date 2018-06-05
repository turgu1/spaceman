class ChangeOrderDefaults < ActiveRecord::Migration[5.1]
  def up
    execute 'update equipment_groups set "order" = 1 where "order" is NULL'
    execute 'update equipment_models set "order" = 1 where "order" is NULL'
    execute 'update field_defs       set "order" = 1 where "order" is NULL'
    execute 'update floors           set "order" = 1 where "order" is NULL'
    execute 'update moving_tasks     set "order" = 1 where "order" is NULL'
    execute 'update orgs             set "order" = 1 where "order" is NULL'
    execute 'update reports          set "order" = 1 where "order" is NULL'
    execute 'update wings            set "order" = 1 where "order" is NULL'

    change_column(:equipment_groups, :order, :integer, default: 1, null: false)
    change_column(:equipment_models, :order, :integer, default: 1, null: false)
    change_column(:field_defs,       :order, :integer, default: 1, null: false)
    change_column(:floors,           :order, :integer, default: 1, null: false)
    change_column(:moving_tasks,     :order, :integer, default: 1, null: false)
    change_column(:orgs,             :order, :integer, default: 1, null: false)
    change_column(:reports,          :order, :integer, default: 1, null: false)
    change_column(:wings,            :order, :integer, default: 1, null: false)
  end
  def down
    change_column(:equipment_groups, :order, :integer, null: true)
    change_column(:equipment_models, :order, :integer, null: true)
    change_column(:field_defs,       :order, :integer, null: true)
    change_column(:floors,           :order, :integer, null: true)
    change_column(:moving_tasks,     :order, :integer, null: true)
    change_column(:orgs,             :order, :integer, null: true)
    change_column(:reports,          :order, :integer, null: true)
    change_column(:wings,            :order, :integer, null: true)
  end
end
