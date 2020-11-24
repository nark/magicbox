class JournalController < ApplicationController
	add_breadcrumb "Journal"
	
	def index
		@observations = Observation.all
	end
end