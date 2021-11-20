class Api::V1::SamplesController < ApiController
	before_action :set_sample, only: [:show, :update, :destroy]

  resource_description do
    short 'Sample data collected by MagicBox'
    description "Samples are values collected from your devices to monitor the environment."
    meta "Sample" => ["id", "data_type_id", "product_reference", "value", "unit", "created_at", "updated_at"]
    formats ['json']
    deprecated false
  end

  def_param_group :sample do
    param :sample, Hash do
      param :product_reference, String, desc: "The sensor product ID", required: true
      param :data_type_id, :number, desc: "The Data Type ID used to determine the nature of the acquired data", required: true
      param :value, String, desc: "The value of the sample retreived from the sensor", required: true
      param :unit, String, desc: "The data unit of the sample value", required: false
    end
  end

  api :GET, '/v1/samples', "Get a list of samples"
  param :limit, :number, desc: "Limit number of samples (default: 100, max: 1000)"
  param :offset, :number, desc: "Offset of samples"
  param :sort_direction, ["asc", "desc"], desc: "The sort direction key"
  param :sort_column, ["id", "data_type_id", "product_reference", "value", "unit", "created_at", "updated_at"], desc: "The sort column name"
  def index
    @samples = Sample.all

    if params[:data_type_id]
      @samples = @samples.where(data_type_id: params[:data_type_id])
    end

    if params.has_key? :sort_direction and params.has_key? :sort_column
      @samples = @samples.order("#{params[:sort_column]} #{params[:sort_direction]}")
    else
      @samples = @samples.order(created_at: :desc)
    end

    if params.has_key? :limit
      @samples = @samples.limit(params[:limit])
    else
      @samples = @samples.limit(100)
    end

    if params.has_key? :offset
      @samples = @samples.offset(params[:offset])
    end

    render json: @samples, include: [data_type: { except: [:created_at, :updated_at] }]
  end




  api :GET, '/v1/samples/:id', "Get a sample item"
  def show
  	render json: @sample
  end



  api :POST, '/v1/samples', "Create a new sample"
  param_group :sample
  # param :product_reference, String, desc: "The sensor product ID", required: true
  # param :data_type_id, :number, desc: "The Data Type ID used to determine the nature of the acquired data", required: true
  # param :value, String, desc: "The value of the sample retreived from the sensor", required: true
  # param :unit, String, desc: "The data unit of the sample value", required: false
  def create
    @sample = Sample.new(sample_params)

    if @sample.save
      render json: @sample, status: :created
    else
      render json: @sample.errors, status: :unprocessable_entity
    end
  end


private
  def set_sample
    @sample = Sample.find(params[:id])
  end

  def sample_params
    params.require(:sample).permit(
      :product_reference,
      :data_type_id,
      :value,
      :unit
    )
  end
end
