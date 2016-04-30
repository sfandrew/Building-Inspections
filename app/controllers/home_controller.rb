class HomeController < ApplicationController
	before_filter :menu_items

  def index
  
  	# if user_signed_in?
  	# 	redirect_to '#' + buildings_path
  	# end
  	

  end

end
