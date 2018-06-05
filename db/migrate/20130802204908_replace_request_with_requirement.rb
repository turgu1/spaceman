class ReplaceRequestWithRequirement < ActiveRecord::Migration[5.1]
  def change
    rename_column :allocations, :request_id, :requirement_id
    rename_column :requests, :request_date, :requirement_date
    rename_column :requests, :request_type, :requirement_type
    rename_table :requests, :requirements
  end
end
