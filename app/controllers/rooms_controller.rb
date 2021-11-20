class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :take_camshot]



  # GET /rooms/1
  # GET /rooms/1.json
  def show
    add_breadcrumb @room.name, @room

    @camera = @room.devices.where(device_type: :camera).first
  end


  def take_camshot
    @room.take_camshot
    redirect_to [:admin, @room], notice: 'Camshot was successfully created.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :room_type, :length, :width, :height, :scenario_id)
    end
end
