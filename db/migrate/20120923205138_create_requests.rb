class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.references :org, index: true
      t.date       :request_date
      t.integer    :request_type
      t.date       :from_date
      t.date       :to_date
      t.boolean    :no_ending
      t.string     :project_name
      t.integer    :desk_count
      t.integer    :desk_count_adjusted
      t.float      :area
      t.float      :area_adjusted
      t.integer    :facility_criteria
      t.integer    :scientific_criteria
      t.integer    :security_criteria
      t.text       :facility_justification
      t.text       :scientific_justification
      t.text       :security_justification
      t.text       :notes
      t.references :requester, index: true
      t.integer    :pm_id
      t.boolean    :pm_ok
      t.integer    :manager_id
      t.boolean    :manager_ok
      t.boolean    :authorized_for_allocation
      t.boolean    :allocation_completed
      t.integer    :created_by

      t.timestamps
    end
  end
end
