class Api::V1::GrowsController < ApiController
	before_action :set_grow, only: [:show]

	# GET /grows
  api :GET, '/v1/grows', "Get a list of grows"
  param :limit, :number, desc: "Limit number of grows (default: 100, max: 1000)"
  param :offset, :number, desc: "Offset of grows"
  param :sort_direction, ["asc", "desc"], desc: "The sort direction key"
  param :sort_column, ["id", "created_at", "updated_at"], desc: "The sort column name"

  def index
    @grows = Grow.all

    if params.has_key? :sort_direction and params.has_key? :sort_column
      @grows = @grows.order("#{params[:sort_column]} #{params[:sort_direction]}")
    else
      @grows = @grows.order(created_at: :asc)
    end

    if params.has_key? :limit
      @grows = @grows.limit(params[:limit])
    else
      @grows = @grows.limit(100)
    end

    if params.has_key? :offset
      @grows = @grows.offset(params[:offset])
    end

    # TODO: rewrite using builder to optimize load and avoid includes
    # render json: @grows, 
    #   include: [
			 #  :observations,
    #     :subjects => {:methods => [:strain_name]},
    #     :weeks => {:methods => [:color]}
    #   ], 
    #   methods: [
    #     :progress_percents, 
    #     :end_date
    #   ]
  end

	# GET /grows/1
  api :GET, '/v1/grows/:id', "Get a grow item"
  def show
    render json: @grow, include: [
    	:subjects,
			:weeks,
			:observations], methods: [:progress_percents, :end_date]
  end

private
	def set_grow
		@grow = Grow.find(params[:id])
	end
end