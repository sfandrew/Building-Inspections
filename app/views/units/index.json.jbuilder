json.array!(@units) do |unit|
  json.extract! unit, :id, :building_id, :unit_number
  json.url unit_url(unit, format: :json)
end
