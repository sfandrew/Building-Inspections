json.array!(@units) do |unit|
  json.(unit, :id, :building_id, :unit_number)
end
