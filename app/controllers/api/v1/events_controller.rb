class Api::V1::EventsController < ApiController
	def index
		@events = Event.all

		if params.has_key? :limit
      @events = @events.limit(params[:limit])
    else
      @events = @events.limit(100)
    end

    if params.has_key? :offset
      @events = @events.offset(params[:offset])
    end

    render json: @events, include: [:room, :device]
	end
end