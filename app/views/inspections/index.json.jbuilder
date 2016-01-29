json.array!(@inspections) do |inspection|
  json.extract! inspection, :id, :description, :unit_id
  json.url inspection_url(inspection, format: :json)
end
