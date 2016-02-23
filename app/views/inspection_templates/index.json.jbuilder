json.array!(@inspection_templates) do |inspection_template|
  json.extract! inspection_template, :id, :name
  json.items_count inspection_template.items.count
    
end
