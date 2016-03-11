require 'rails_helper'

RSpec.describe Score::PassFail, type: :model do
  it "initializes the correct score class from the type" do
    expect(Score.create("PassFail").class.name).to eq("Score::PassFail")
  end

  it "initializes raw score to valid value" do
    expect(Score.create("PassFail").raw_score).to eq("fail")
  end

  it "can initialize with a pass or fail value" do
    expect(Score.create("PassFail", "pass").pass?).to eq(true)
    expect(Score.create("PassFail", "fail").fail?).to eq(true)
  end

  it "can change the score value and has methods to check its value" do
    score = Score.create("PassFail", "fail")
    expect(score.pass?).to eq(false)
    expect(score.fail?).to eq(true)
    score.set_pass
    expect(score.pass?).to eq(true)
    expect(score.fail?).to eq(false)
  end

  it "responds to get_score and set_score properly" do
    score = Score.create("PassFail", "fail")
    expect(score.get_score).to eq("fail")
    score.set_score("pass")
    expect(score.pass?).to eq(true)
    expect(score.get_score).to eq("pass")
  end

end
