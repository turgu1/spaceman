class ChangeQtyDefaultOfMovingItems < ActiveRecord::Migration[5.1]
  def change
  	reversible do |dir|
  		dir.up do
        execute 'update moving_items set "qty" = 1 where "qty" is NULL'

		    change_column(:moving_items, :qty, :integer, default: 1, null: false)
      end

      dir.down do
        change_column(:moving_items, :qty, :integer, null: true)
      end
    end

  end
end
