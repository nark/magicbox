class JournalController < ApplicationController
	add_breadcrumb "Journal"
	
	def index
		#@observations = Observation.all
		@events = Event.all.limit(100).order(created_at: :desc)
	end
end