class InspectionTemplate::Item < ActiveRecord::Base
  belongs_to :inspection_template, class_name: 'InspectionTemplate'

  validates :name, 
  :inspection_template, 
  :position, 
  :section, 
  :weight,
  :score_type, 
  	presence: true
end
