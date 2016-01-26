class InspectionTemplate < ActiveRecord::Base
  belongs_to :unit
  has_many :items, -> { order(item_order: :asc) }, class_name: 'InspectionTemplate::Item'

  validates :unit, presence: true

end
