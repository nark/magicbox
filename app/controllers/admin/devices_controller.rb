class Admin::DevicesController < ApplicationController
	before_action :authenticate_user!
  before_action :set_device, only: [:show, :edit, :update, :destroy, :start, :stop]

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
	end


  def show
    @samples = Sample.where(data_type: @device.data_types).limit(100)
    @values = @samples.order(created_at: :desc).limit(100).map { |e| [e.created_at, e.value]  }
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
      redirect_to admin_device_path(@device), notice: 'Device created with success.'
    else
      render :new
    end
  end


  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      redirect_to admin_device_path(@device), notice: 'Device updated with success.'
    else
      render :edit
    end
  end


  def destroy
    @device.destroy
    redirect_to admin_devices_path, notice: 'Device deleted with success.'
  end


  def start
    @device.start
    redirect_to admin_devices_path, notice: 'Device started'
  end


  def stop
    @device.stop
    redirect_to admin_devices_path, notice: 'Device stopped'
  end


private
  # Use callbacks to share common setup or constraints between actions.
  def set_device
    @device = Device.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def device_params
    params.require(:device).permit(:room_id, :device_type, :device_state, :pin_number, :pin_type, :default_duration, :name, :product_reference, :description, :last_start_date)
  end
end