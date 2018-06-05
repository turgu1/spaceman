json.array!(@reports) do |report|
  json.extract! report, :name, :group, :order, :script, :view
  json.url report_url(report, format: :json)
end
