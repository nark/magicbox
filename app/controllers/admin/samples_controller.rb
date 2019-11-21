class Admin::SamplesController < Admin::AdminController
	before_action :authenticate_user!

	add_breadcrumb "Statistics"
	
	def index	
		
	end
end