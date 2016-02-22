json.array!(@inspection_templates) do |inspection_template|
  json.extract! inspection_template, :id, :name
end
