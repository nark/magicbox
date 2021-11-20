class Api::V1::RoomsController < ApiController
	before_action :set_room, only: [:show]

	# GET /rooms
  api :GET, '/v1/rooms', "Get a list of rooms"
  param :limit, :number, desc: "Limit number of rooms (default: 100, max: 1000)"
  param :offset, :number, desc: "Offset of rooms"
  param :sort_direction, ["asc", "desc"], desc: "The sort direction key"
  param :sort_column, ["id", "created_at", "updated_at"], desc: "The sort column name"

  def index
    @rooms = Room.all

    if params.has_key? :sort_direction and params.has_key? :sort_column
      @rooms = @rooms.order("#{params[:sort_column]} #{params[:sort_direction]}")
    else
      @rooms = @rooms.order(created_at: :asc)
    end

    if params.has_key? :limit
      @rooms = @rooms.limit(params[:limit])
    else
      @rooms = @rooms.limit(100)
    end

    if params.has_key? :offset
      @rooms = @rooms.offset(params[:offset])
    end
  end


	# GET /grows/1
  api :GET, '/v1/rooms/:id', "Get a room item"
  def show
    render json: @room, include: [
    	:subjects,
			:devices,
			:events,
			:observations,
			:scenario]
  end


 private
   def set_room
   		@room = Room.find(params[:id])
   end
end