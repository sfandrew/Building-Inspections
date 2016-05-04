class InspectionTemplate < ActiveRecord::Base
  belongs_to :unit
  belongs_to :user
  has_many :items, -> { order(position: :asc) }, class_name: 'InspectionTemplate::Item'
  scope :recent_inspection_templates, ->(current_user) { where(user: current_user).last(5) }
  accepts_nested_attributes_for :items, allow_destroy: true

  serialize :sections, Array

  validates :name, presence: true
  validate :sections_are_unique


  def sections_are_unique
  	if sections.uniq.length != sections.length
  		errors.add(:sections, "are not unique")
  	end
  end
end
