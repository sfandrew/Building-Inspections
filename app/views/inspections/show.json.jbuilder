json.(@inspection, :id, :description, :unit_id, :created_at, :updated_at)
json.items do
  json.array!(@inspection.items) do |item|
    json.(item, :id, :name, :section, :position)
  end
end