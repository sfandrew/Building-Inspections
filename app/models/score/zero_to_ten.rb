class Score::ZeroToTen < Score
  def initialize(raw_score = nil)
    @raw_score = raw_score || 0
  end
end