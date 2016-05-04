class Inspection < ActiveRecord::Base
  attr_accessor :template_id
  scope :recent_inspections, ->(current_user) { where(user: current_user).last(5) }

  belongs_to :unit
  belongs_to :building
  belongs_to :user
  has_many :items, -> { order(position: :asc) }, 
    class_name: "Inspection::Item", 
    autosave: true, 
    dependent: :destroy

  serialize :sections, Array

  validates :unit, presence: true
  validates :building, presence: true
  validates :template_id, presence: true, on: :create
  validate :sections_are_unique

  before_validation :build_inspection_and_items_from_template, if: :new_record?

  accepts_nested_attributes_for :items

  def template=(template)
    @template_id = template.id if template
  end

  def template_id=(template_id)
    @template_id = template_id
  end

  def build_inspection_and_items_from_template
    template = InspectionTemplate.where(id: @template_id)

    template = template.first || return

    self.sections = template.sections

    return if items.count > 0 # Don't accidentally create the items twice

    if (template.items.count < 1)
      errors.add(:base, "Template has no items!")
      return
    end
    template.items.each do |template_item|
      new_item = Inspection::Item.build_from_template_item(template_item)
      new_item.inspection = self
      self.items << new_item
    end
  end

  def sections_are_unique
    if sections.uniq.length != sections.length
      errors.add(:sections, "are not unique")
    end
  end


end
