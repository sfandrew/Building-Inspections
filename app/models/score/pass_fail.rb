class Score::PassFail < Score
  def initialize(raw_score = nil)
    @raw_score = raw_score || false
  end
end