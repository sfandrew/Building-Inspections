require 'rails_helper'

RSpec.describe "Buildings", type: :feature do
  describe "Managing Buildings" do
    it "creates a new building and displays its attributes" do
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
      page.should have_content "Building was successfully created."
      page.should have_content "building1"
      page.should have_content "123 fake st."
      page.should have_content "San Francisco"
      page.should have_content "California"
      page.should have_content "94117"
    end
  end
end