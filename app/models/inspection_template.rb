class InspectionTemplate < ActiveRecord::Base
  belongs_to :unit

  validates :unit, presence: true

end
