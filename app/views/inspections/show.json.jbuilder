json.(@inspection, :id, :description, :building_id, :unit_id, :created_at, :updated_at, :sections)
json.items_count @inspection.items.count
json.items do
  json.array!(@inspection.items) do |item|
    json.(item, :id, :name, :section, :position, :weight, :score_type)
    json.score (item.score.get_score)
  end
end