class Inspection::Item < ActiveRecord::Base
  belongs_to :inspection

  validates :name, :section, :position, :inspection, presence: true

  def self.build_from_template_item(template_item)    
    self.new(
      name: template_item.name,
      weight: template_item.weight,
      section: template_item.section,
      position: template_item.position,
      score_type: template_item.score_type)
  end

  # used in tests to check if this item is instantiated properly from its template
  def matches_template_item?(template_item)
    return false if template_item.nil?
    return false if self.name != template_item.name
    return false if self.section != template_item.section
    return false if self.weight != template_item.weight
    return false if self.position != template_item.position
    return false if self.score_type != template_item.score_type
    true
  end

  def score
    @score ||= Score.create(score_type)
  end

end
