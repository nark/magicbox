class DashboardController < ApplicationController
	before_action :authenticate_user!

	add_breadcrumb "Dashboard"
	
	def index
		@grows = Grow.where.not(grow_status: [:done, :aborted])
		@todos = current_user.todos.where(todo_status: :todo).limit(10)
	end
end