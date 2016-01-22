require 'rails_helper'

RSpec.describe "buildings/show", type: :view do
  before(:each) do
    @building = assign(:building, Building.create!(
      :name => "Name",
      :address_line_1 => "Address Line 1",
      :address_line_2 => "Address Line 2",
      :city => "City",
      :state => "State",
      :zip => "Zip"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address Line 1/)
    expect(rendered).to match(/Address Line 2/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Zip/)
  end
end
