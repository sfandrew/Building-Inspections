require 'rails_helper'

RSpec.describe Building, type: :model do
  it "requires a name, address line one, and zip" do
    valid_building = Building.build(name: "building1", address_line_1: "123 fake st.", zip: "94117")
    missing_name = Building.build(address_line_1: "123 fake st.", zip: "94117")
    missing_address = Building.build(name: "building1", zip: "94117")
    missing_zip = Building.build(name: "building1", address_line_one: "123 fake st.")

  end
end
