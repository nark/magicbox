class Api::V1::DevicesController < ApiController
  before_action :set_device, only: [:show, :update, :destroy, :start, :stop]

  resource_description do
    short 'Active devices managed by MagixBox'
    description "Devices regroups all the active modules that interact with the MagicBox environment such as sensors, fans, pumps, etc."
    meta "Device" => ["id", "device_type", "device_state", "pin_number", "pin_type", "name", "product_reference", "description", "last_start_date", "created_at", "updated_at"]
    formats ['json']
    deprecated false
  end


  # GET /devices
  api :GET, '/v1/devices', "Get a list of devices"
  param :limit, :number, desc: "Limit number of devices (default: 100, max: 1000)"
  param :offset, :number, desc: "Offset of devices"
  param :sort_direction, ["asc", "desc"], desc: "The sort direction key"
  param :sort_column, ["id", "device_type", "device_state", "name", "pin_number", "pin_type", "product_reference", "description", "last_start_date", "created_at", "updated_at"], desc: "The sort column name"
  def index
    @devices = Device.all

    if params.has_key? :sort_direction and params.has_key? :sort_column
      @devices = @devices.order("#{params[:sort_column]} #{params[:sort_direction]}")
    else
      @devices = @devices.order(created_at: :asc)
    end

    if params.has_key? :limit
      @devices = @devices.limit(params[:limit])
    else
      @devices = @devices.limit(100)
    end

    if params.has_key? :offset
      @devices = @devices.offset(params[:offset])
    end

    render json: @devices, include: [:data_types]
  end



  # GET /devices/1
  api :GET, '/v1/devices/:id', "Get a device item"
  def show
    render json: @device, include: [:data_types]
  end



  # POST /devices
  def create
    @device = Device.new(device_params)

    if @device.save
      render json: @device, status: :created, location: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      render json: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end



  # DELETE /devices/1
  def destroy
    @device.destroy
  end



  api :POST, '/v1/devices/:id/start', "Start a device"
  def start
    if @device.off?
      # result = `python scripts/arduino.py COMMAND:DIGITAL_WRITE:#{@device.pin_number}:1:#{@device.default_duration}`
      # response = JSON.parse(result)
      # puts response

      # @device.device_state = :on
      # @device.save
      render json: @device
    elsif @device.idle?
      render :json => { :errors => "Device is not managable" }
    else
      render :json => { :errors => "Device already started" }
    end
  end


  api :POST, '/v1/devices/:id/stop', "Stop a device"
  def stop
    if @device.on?
      # result = `python scripts/arduino.py COMMAND:DIGITAL_WRITE:#{@device.pin_number}:0:#{@device.default_duration}`
      # puts result

      # @device.device_state = :off
      # @device.save
      render json: @device

    elsif @device.idle?
      render :json => { :errors => "Device is not managable" }
    else
      render :json => { :errors => "Device already stopped" }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.require(:device).permit(:device_type, :device_state, :pin_number, :default_duration, :pin_type, :name, :product_reference, :description, :last_start_date)
    end
end
