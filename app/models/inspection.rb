class Inspection < ActiveRecord::Base
  attr_accessor :template_id

  belongs_to :unit
  has_many :items, -> { order(position: :asc) }, 
    class_name: "Inspection::Item", 
    autosave: true, 
    dependent: :destroy

  validates :unit, presence: true
  validates :template_id, presence: true, on: :create

  before_validation :create_items_from_template, if: :new_record?

  accepts_nested_attributes_for :items

  def template=(template)
    @template_id = template.id if template
  end

  def template_id=(template_id)
    @template_id = template_id
  end

  def create_items_from_template
    return if items.count > 0 # Don't accidentally create the items twice
    template = InspectionTemplate.where(id: @template_id)
    return if !template.first
    template.first.items.each do |template_item|
      new_item = Inspection::Item.build_from_template_item(template_item)
      new_item.inspection = self
      self.items << new_item
    end
  end

end
