class RegistrationsController < Devise::RegistrationsController
	before_filter :menu_items
end