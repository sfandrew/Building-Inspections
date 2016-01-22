class Unit < ActiveRecord::Base
  validates :unit_number, presence: true

  belongs_to :building

  validates :building, presence: true
end
