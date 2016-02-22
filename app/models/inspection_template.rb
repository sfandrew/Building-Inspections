class InspectionTemplate < ActiveRecord::Base
  belongs_to :unit
  has_many :items, -> { order(position: :asc) }, class_name: 'InspectionTemplate::Item'

  validates :name, presence: true


  def update_items(new_items)
    new_items.each do |new_item|
      matching_item = self.items.find{|i| i.id != nil && i.id == new_item[:id] }
      if matching_item
        matching_item.update(new_item)
      else
        self.items.build(new_item)
      end
    end
  end
end
