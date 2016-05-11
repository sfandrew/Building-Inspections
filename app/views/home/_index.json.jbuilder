json.array!(@buildings) do |building|
  json.(building, :id, :name, :address_line_1, :address_line_2, :city, :state, :zip)
  json.units_count building.units.count
end