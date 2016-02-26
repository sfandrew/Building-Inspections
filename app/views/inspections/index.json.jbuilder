json.array!(@inspections) do |inspection|
  json.extract! inspection, :id, :description, :unit_id
  json.items_count inspection.items.count
end
