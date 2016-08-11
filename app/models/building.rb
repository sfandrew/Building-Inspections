class Building < ActiveRecord::Base
	scope :recent_buildings, ->(current_user) { where(user: current_user).last(5) }

	has_many :units
	belongs_to :user

	mount_uploaders :photos, BuildingPhotosUploader

	validates :name, :address_line_1, :zip, :city, :state, presence: true
	geocoded_by :full_address
	after_validation :geocode, if: :address_fields_changed?


	def full_address
		[address_line_1, city, zip, state].compact.join(',')
	end

	def address_fields_changed?
		attrs = %w(address_line_1 city state zip)
  	attrs.any?{|a| send "#{a}_changed?"}
  end

end
