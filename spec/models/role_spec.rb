require 'rails_helper'

RSpec.describe Role, type: :model do
  it "loads the base roles correctly" do
  	expect(Role.where(name: "Regular")).to exist
  	expect(Role.where(name: "Admin")).to exist
  end
end
