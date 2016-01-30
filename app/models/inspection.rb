class Inspection < ActiveRecord::Base
  attr_accessor :template

  belongs_to :unit
  has_many :items, -> { order(position: :asc) }, class_name: "Inspection::Item"

  validates :unit, presence: true
  #validates :item, presence: true
  validates :template, presence: true, on: :create


  before_create :create_items_from_template


  def create_items_from_template
    @template.items.each do |template_item|

    end
  end

end
