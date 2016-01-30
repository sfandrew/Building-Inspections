class Inspection::Item < ActiveRecord::Base
	belongs_to :inspection

	validates :name, :weight, :section, :position, :inspection, presence: true


	def self.build_from_template_item(template_item)		
		self.new(
			weight: template_item.weight,
			section: template_item.section,
			position: template_item.item_order)
	end
end
