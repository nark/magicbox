class CalendarController < ApplicationController
	add_breadcrumb "Calendar"

	def index
		@issues_json = Issue.where(issue_status: :open).to_json(methods: [:start_date, :end_date, :text, :url, :color])
		@todos_json = current_user.todos.to_json(methods: [:text, :url, :color, :start_date, :end_date])
		@weeks_json = Week.joins(:grow).where.not('grows.grow_status': [:done, :aborted]).to_json(methods: [:text, :url, :color])
    @observations_json = Observation.all.to_json(methods: [:start_date, :end_date, :text, :url])
	end
end