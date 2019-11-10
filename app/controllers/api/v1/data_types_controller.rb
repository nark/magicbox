class Api::V1::DataTypesController < ApiController
  before_action :set_data_type, only: [:show, :update, :destroy]

  resource_description do
    short 'DataType from devices'
    description "DataType are used to define the output value returned by a qualified device, like a sensor."
    meta "DataType" => ["id", "name", "created_at", "updated_at"]
    formats ['json']
    deprecated false
  end

  # GET /data_types
  api :GET, '/v1/data_types', "Get a list of data types"
  def index
    @data_types = DataType.all

    render json: @data_types, except:  [:created_at, :updated_at]
  end

  # GET /data_types/1
  api :GET, '/v1/data_types/:id', "Get a data types item"
  def show
    render json: @data_type
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_type
      @data_type = DataType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def data_type_params
      params.require(:data_type).permit(:name)
    end
end
