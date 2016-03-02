class InspectionTemplate::Item < ActiveRecord::Base
  belongs_to :inspection_template, class_name: 'InspectionTemplate'

  validates :name, :inspection_template, :position, :section, :weight, presence: true
end
