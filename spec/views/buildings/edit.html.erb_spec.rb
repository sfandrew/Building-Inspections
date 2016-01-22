require 'rails_helper'

RSpec.describe "buildings/edit", type: :view do
  before(:each) do
    @building = assign(:building, Building.create!(
      :name => "MyString",
      :address_line_1 => "MyString",
      :address_line_2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString"
    ))
  end

  it "renders the edit building form" do
    render

    assert_select "form[action=?][method=?]", building_path(@building), "post" do

      assert_select "input#building_name[name=?]", "building[name]"

      assert_select "input#building_address_line_1[name=?]", "building[address_line_1]"

      assert_select "input#building_address_line_2[name=?]", "building[address_line_2]"

      assert_select "input#building_city[name=?]", "building[city]"

      assert_select "input#building_state[name=?]", "building[state]"

      assert_select "input#building_zip[name=?]", "building[zip]"
    end
  end
end
