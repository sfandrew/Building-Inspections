json.array!(@buildings) do |building|
  json.extract! building, :id, :name, :address_line_1, :address_line_2, :city, :state, :zip
  json.url building_url(building, format: :json)
end
