class AddEnableToReport < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :enabled, :boolean
  end
end
