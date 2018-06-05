json.array!(@moving_tasks) do |moving_task|
  json.extract! moving_task, :name, :description, :specialty_id, :responsability, :order, :duration, :cost
  json.url moving_task_url(moving_task, format: :json)
end
