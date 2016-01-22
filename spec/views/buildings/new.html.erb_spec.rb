require 'rails_helper'

RSpec.describe "buildings/new", type: :view do
  before(:each) do
    assign(:building, Building.new(
      :name => "MyString",
      :address_line_1 => "MyString",
      :address_line_2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString"
    ))
  end

  it "renders new building form" do
    render

    assert_select "form[action=?][method=?]", buildings_path, "post" do

      assert_select "input#building_name[name=?]", "building[name]"

      assert_select "input#building_address_line_1[name=?]", "building[address_line_1]"

      assert_select "input#building_address_line_2[name=?]", "building[address_line_2]"

      assert_select "input#building_city[name=?]", "building[city]"

      assert_select "input#building_state[name=?]", "building[state]"

      assert_select "input#building_zip[name=?]", "building[zip]"
    end
  end
end
