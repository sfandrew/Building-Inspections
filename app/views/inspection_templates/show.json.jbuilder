json.extract! @inspection_template, :id, :name, :created_at, :updated_at
json.items do
  json.array!(@inspection_template.items) do |item|
    json.extract! item, :id, :name, :section, :position
  end
end