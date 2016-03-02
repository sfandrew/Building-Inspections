class Inspection < ActiveRecord::Base
  attr_accessor :template_id

  belongs_to :unit
  has_many :items, -> { order(position: :asc) }, class_name: "Inspection::Item", autosave: true

  validates :unit, presence: true
  validates :template_id, presence: true, on: :create

  before_create :create_items_from_template

  accepts_nested_attributes_for :items

  def template=(template)
    @template_id = template.id if template
  end

  def template_id=(template_id)
    @template_id = template_id
  end

  def create_items_from_template
    template = InspectionTemplate.find(@template_id)
    template.items.each do |template_item|
      self.items << Inspection::Item.build_from_template_item(template_item)
    end
  end

end
