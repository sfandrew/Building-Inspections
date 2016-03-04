require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid regular user factory" do
  	user = FactoryGirl.create(:user)
  	expect(user).to be_valid
  	expect(user.role.name).to eq("Regular")
  end

  it "has a valid admin factory" do
  	admin = FactoryGirl.create(:admin)
  	expect(admin).to be_valid
  	expect(admin.role.name).to eq("Admin")
  end

  it "is invalid without a name" do
  	expect(FactoryGirl.build(:user, name: nil)).not_to be_valid
  end

  it "is invalid without an e-mail address" do
  	expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
  end
end
