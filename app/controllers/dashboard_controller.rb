class DashboardController < ApplicationController
	before_action :authenticate_user!

	add_breadcrumb "Dashboard"
	
	def index
		@grows = Grow.where.not(grow_status: [:done, :aborted])
		@todos = current_user.todos.where(todo_status: :todo).limit(10)
		# @samples = Sample.order(created_at: :desc).limit(100)

		# @temperatures_values 		= Sample.where(data_type_id: 1).order(created_at: :desc).limit(100).map { |e| [e.created_at, e.value]  }
		# @humiditys_values 			= Sample.where(data_type_id: 2).order(created_at: :desc).limit(100).map { |e| [e.created_at, e.value]  }
		# @water_levels_values 		= Sample.where(data_type_id: 4).order(created_at: :desc).limit(100).map { |e| [e.created_at, e.value]  }
		# @soil_moistures_values 	= Sample.where(data_type_id: 3).order(created_at: :desc).limit(100).map { |e| [e.created_at, e.value]  }
	end
end