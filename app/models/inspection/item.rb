class Inspection::Item < ActiveRecord::Base
  belongs_to :inspection

  validates :name, :weight, :section, :position, :inspection, presence: true

  validate :validate_score

  def self.build_from_template_item(template_item)    
    self.new(
      name: template_item.name,
      weight: template_item.weight,
      section: template_item.section,
      position: template_item.position)
  end

  # used in tests to check if this item is instantiated properly from its template
  def matches_template_item?(template_item)
    return false if template_item.nil?
    return false if self.name != template_item.name
    return false if self.section != template_item.section
    return false if self.weight != template_item.weight
    return false if self.position != template_item.position
    true
  end

  private

  def validate_score
    return if score.nil?
    unless (score >= 0) && (score <= 10)
      errors.add(:score, "must be between 0 and 10, inclusive.")
      return
    end
  end
end
