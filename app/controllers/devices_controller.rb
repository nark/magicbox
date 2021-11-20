class DevicesController < ApplicationController
	before_action :authenticate_user!
  before_action :set_room, only: [:index, :new, :show, :edit, :update, :destroy, :start, :stop, :samples, :query]
  before_action :set_device, only: [:show, :edit, :update, :destroy, :start, :stop, :query]



  def show
    @samples = @device.samples.limit(100)
    @values = @samples.where(data_type: DataType.where(name: "temperature").first).order(created_at: :desc).map { |e| [e.created_at, e.value]  }
  end


  def query
    @device.query_sensor
    redirect_to room_path(@room), notice: 'Query device succeeded.'
  end


private
  def set_room
    if params[:room_id].present?
      @room = Room.find(params[:room_id])

      add_breadcrumb @room.name, @room
    end
  end

  def set_device
    @device = Device.find(params[:id])

    add_breadcrumb @device.name, [@room, @device]
  end

  # Only allow a trusted parameter "white list" through.
  def device_params
    params.require(:device).permit(:room_id, :device_type, :device_state, :pin_number, :pin_type, :default_duration, :name, :product_reference, :description, :last_start_date, :use_duration, :watts, :volts, :amperes, :custom_identifier)
  end
end