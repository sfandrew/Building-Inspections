class InspectionTemplate < ActiveRecord::Base
  belongs_to :unit
  has_many :items, -> { order(position: :asc) }, class_name: 'InspectionTemplate::Item'
  accepts_nested_attributes_for :items, allow_destroy: true

  validates :name, presence: true
end
