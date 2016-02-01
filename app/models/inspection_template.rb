class InspectionTemplate < ActiveRecord::Base
  belongs_to :unit
  has_many :items, -> { order(position: :asc) }, class_name: 'InspectionTemplate::Item'

  validates :name, presence: true

end
