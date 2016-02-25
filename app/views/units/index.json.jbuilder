json.array!(@units) do |unit|
  json.extract! unit, :id, :building_id, :unit_number
end
