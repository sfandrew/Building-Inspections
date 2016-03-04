require 'rails_helper'

RSpec.describe "Buildings", type: :feature do
  describe "Managing Buildings" do
    it "creates a new building and displays its attributes" do
      skip("Obsolete with angular interface?")
      visit buildings_url
      expect{
        click_link 'New Building'
        fill_in 'Name', with: "building1"
        fill_in 'Address line 1', with: "123 fake st."
        fill_in 'City', with: "San Francisco"
        fill_in 'State', with: "California"
        fill_in 'Zip', with: "94117"
        click_button "Create Building"
      }.to change(Building, :count).by(1)
      expect(page).to have_content "Building was successfully created."
      expect(page).to have_content "building1"
      expect(page).to have_content "123 fake st."
      expect(page).to have_content "San Francisco"
      expect(page).to have_content "California"
      expect(page).to have_content "94117"
    end

    it "deletes a building" do
      skip("Obsolete with angular interface?")
      building = FactoryGirl.create(:building, name: "testbuilding")
      visit buildings_path
      expect {
        click_link 'Destroy'
      }.to change(Building, :count).by(-1)
      expect(page).to have_content "Listing Buildings"
      expect(page).to_not have_content "testbuilding"
    end
  end
end