class Score::PassFail < Score

  attr_reader :raw_score

  def initialize(raw_score = nil)
    raw_score.nil? ? set_fail : set_score(raw_score)
  end

  def pass?
    @raw_score == "pass"
  end

  def fail?
    @raw_score == "fail"
  end

  def set_pass
    @raw_score = "pass"
  end

  def set_fail
    @raw_score = "fail"
  end

  def set_score(str)
    if ["pass", "fail"].include?(str)
      @raw_score = str
    else
      raise "Invalid pass/fail score value: '#{str}'. Valid values are 'pass' or 'fail'"
    end
  end

  def get_score
    @raw_score
  end
end