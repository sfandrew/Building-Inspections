require 'rails_helper'

RSpec.describe "InspectionTemplates", type: :request do
  describe "Managing Templates" do
    it "creates a new template and displays its attributes" do
      visit templates_url
      expect{
        click_link 'New Template'
        fill_in 'Name', with: "building1"
        click_button "Create Template"
      }.to change(Building, :count).by(1)
      expect(page).to have_content "Building was successfully created."
      expect(page).to have_content "building1"
      expect(page).to have_content "123 fake st."
      expect(page).to have_content "San Francisco"
      expect(page).to have_content "California"
      expect(page).to have_content "94117"
    end

    it "deletes a building" do
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
