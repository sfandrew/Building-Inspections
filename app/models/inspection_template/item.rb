class InspectionTemplate::Item < ActiveRecord::Base
  belongs_to :inspection_template

  validates :inspection_template, :item_order, :section, presence: true
end
