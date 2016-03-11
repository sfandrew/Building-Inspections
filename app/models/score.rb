class Score

  def score
    @raw_score
  end

  def type
    self.class.name.split("::").last
  end

  def self.create(score_type, initial_value = nil)
    if valid_score_types.include?(score_type)
      const_get(score_type).new(initial_value)
    else
      raise "Invalid score type: #{score_type}"
    end
  end

  def self.valid_score_types
    ["PassFail", "ZeroToTen"]
  end
end
