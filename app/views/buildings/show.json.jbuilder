json.(@building, :id, :name, :address_line_1, :address_line_2, :city, :state, :zip, :created_at, :updated_at, :latitude, :longitude)
json.units do
  json.array!(@building.units) do |unit|
    json.( unit, :id, :unit_number)
  end
end