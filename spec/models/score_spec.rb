require 'rails_helper'

RSpec.describe Score, type: :model do
  it "has a Class Method to list valid score types" do
    puts "\nInspection class: #{Inspection.class}\n"
    expect(Score.valid_score_types).to include("PassFail")
  end

  context "when using zero to ten score type" do
    it "initializes the correct score class from the type" do
      expect(Score.create("ZeroToTen").class.name).to eq("Score::ZeroToTen")
    end

    it "initializes score to valid value" do
      expect(Score.create("ZeroToTen").score).to eq("0")
    end
  end
end
