class HomeController < ApplicationController
	before_filter :menu_items

  def index
  	@buildings = Building.where(user: current_user) if user_signed_in?
  end

end
