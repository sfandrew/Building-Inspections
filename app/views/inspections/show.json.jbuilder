json.(@inspection, :id, :description, :unit_id, :created_at, :updated_at)
json.items_count @inspection.items.count
json.items do
  json.array!(@inspection.items) do |item|
    json.(item, :id, :name, :section, :position, :score, :weight)
  end
end