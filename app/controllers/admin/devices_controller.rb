class Admin::DevicesController < Admin::AdminController
	before_action :authenticate_user!
  before_action :set_room, only: [:index, :new, :show, :edit, :update, :destroy, :start, :stop, :samples, :query]
  before_action :set_device, only: [:show, :edit, :update, :destroy, :start, :stop, :query]

	def index
    add_breadcrumb "Devices"

		@devices = @room ? @room.devices : Device.all

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
	end


  def show
    @samples = @device.samples.limit(100)

    @values = @samples.where(data_type: DataType.where(name: "temperature").first).order(created_at: :desc).map { |e| [e.created_at, e.value]  }
    #@values = @samples.where(data_type: :humidity).order(created_at: :desc).limit(100).map { |e| [e.created_at, e.value]  }
  end


  def new
    @device = Device.new
  end


  def edit
    
  end


  # POST /devices
  def create
    @device = Device.new(device_params)

    if @device.save
      redirect_to room_device_path(@device.room, @device), notice: 'Device created with success.'
    else
      render :new
    end
  end


  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      redirect_to room_device_path(@device.room, @device), notice: 'Device updated with success.'
    else
      render :edit
    end
  end


  def destroy
    @device.destroy
    redirect_to room_path(@room), notice: 'Device deleted with success.'
  end


  def start
    result = @device.start 

    if result == true
      redirect_back fallback_location: room_path(@room), notice: 'Device started'
    else
      redirect_back fallback_location: room_path(@room), alert: "Device error: #{result}"
    end
  end


  def stop
    result = @device.stop 

    if result == true
      redirect_back fallback_location: room_path(@room), notice: 'Device stopped'
    else
      redirect_back fallback_location: room_path(@room), alert: "Device error: #{result}"
    end
  end


  def query
    @device.query_sensor
    redirect_back fallback_location:  room_path(@room), notice: 'Query OK'
  end


  def samples
    @devices = @room.devices
  end


private
  def set_room
    if params[:room_id].present?
      @room = Room.find(params[:room_id])

      add_breadcrumb @room.name, [:admin, @room]
    end
  end

  def set_device
    @device = Device.find(params[:id])

    add_breadcrumb @device.name, [:admin, @room, @device]
  end

  # Only allow a trusted parameter "white list" through.
  def device_params
    params.require(:device).permit(:room_id, :device_type, :device_state, :pin_number, :pin_type, :default_duration, :name, :product_reference, :description, :last_start_date, :use_duration, :watts, :volts, :amperes)
  end
end