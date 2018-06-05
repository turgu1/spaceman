json.array!(@table_defs) do |table_def|
  json.extract! table_def, :name
  json.url table_def_url(table_def, format: :json)
end
