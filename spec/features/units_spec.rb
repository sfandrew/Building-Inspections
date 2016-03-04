require 'rails_helper'

RSpec.describe "Units", type: :feature do

  let(:building) {
    FactoryGirl.create(:building)
  }

  describe "Managing Units" do
    it "creates a new unit and displays its attributes" do
      skip("Obsolete with angular interface?")
      visit building_units_url(building)
      expect{
        click_link 'New Unit'
        fill_in 'Unit number', with: "101A"
        click_button "Create Unit"
      }.to change(building.units, :count).by(1)
      expect(page).to have_content "Unit was successfully created."
      expect(page).to have_content "101A"
    end

    it "deletes a unit" do
      skip("Obsolete with angular interface?")
      unit = FactoryGirl.create(:unit, unit_number: "test_unit_number", building: building)
      visit building_units_path(building)
      expect {
        click_link 'Destroy'
      }.to change(building.units, :count).by(-1)
      expect(page).to have_content "Listing Units"
      expect(page).to_not have_content "test_unit_number"
    end
  end
end
