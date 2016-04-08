json.array!(@inspection_templates) do |inspection_template|
  json.(inspection_template, :id, :name, :sections)
  json.items_count inspection_template.items.count
    
end
