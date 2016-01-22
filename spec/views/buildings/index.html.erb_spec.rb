require 'rails_helper'

RSpec.describe "buildings/index", type: :view do
  before(:each) do
    assign(:buildings, [
      Building.create!(
        :name => "Name",
        :address_line_1 => "Address Line 1",
        :address_line_2 => "Address Line 2",
        :city => "City",
        :state => "State",
        :zip => "Zip"
      ),
      Building.create!(
        :name => "Name",
        :address_line_1 => "Address Line 1",
        :address_line_2 => "Address Line 2",
        :city => "City",
        :state => "State",
        :zip => "Zip"
      )
    ])
  end

  it "renders a list of buildings" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address Line 1".to_s, :count => 2
    assert_select "tr>td", :text => "Address Line 2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
  end
end
