class Score::ZeroToTen < Score
  def initialize(raw_score = nil)
    set_score(raw_score)
  end

  def set_score(new_score)
  	score_as_integer = new_score.to_i
  	# Clamps score between 0-10
  	@raw_score = [0,score_as_integer,10].sort[1].to_s
  end
end