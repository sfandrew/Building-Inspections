class Inspection < ActiveRecord::Base
	attr_accessor :template

	belongs_to :unit
	has_many :items

	validates :unit, presence: true
	validates :template, presence: true, on: :create

end
