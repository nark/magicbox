class Admin::CategoriesController < Admin::AdminController
	before_action :authenticate_user!

	add_breadcrumb "Categories"
	
	def index
		@categories = Category.all
	end
end