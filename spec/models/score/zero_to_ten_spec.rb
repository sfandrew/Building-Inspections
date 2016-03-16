require 'rails_helper'

RSpec.describe Score::ZeroToTen, type: :model do
  it "initializes the correct score class from the type" do
    expect(Score.create("ZeroToTen").class.name).to eq("Score::ZeroToTen")
  end

  it "initializes raw score to valid value" do
    expect(Score.create("ZeroToTen").raw_score).to eq("0")
  end

  it "can initialize with a numerical value" do
    expect(Score.create("ZeroToTen", "2").raw_score).to eq("2")
    expect(Score.create("ZeroToTen", "5").raw_score).to eq("5")
  end

  it "clamps values to within 0-10" do
    expect(Score.create("ZeroToTen", "-1").raw_score).to eq("0")
    expect(Score.create("ZeroToTen", "11").raw_score).to eq("10")
  end

  it "responds to get_score and set_score properly" do
    score = Score.create("ZeroToTen", "3")
    expect(score.get_score).to eq("3")
    score.set_score("5")
    expect(score.get_score).to eq("5")
  end

end
