class Building < ActiveRecord::Base

	validates :name, :address_line_1, :zip, :city, :state, presence: true
		
end
