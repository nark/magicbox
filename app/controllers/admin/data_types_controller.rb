class Admin::DataTypesController < Admin::AdminController
	before_action :authenticate_user!

	add_breadcrumb "Data types"
	
	def index
		@data_types = DataType.all
	end
end