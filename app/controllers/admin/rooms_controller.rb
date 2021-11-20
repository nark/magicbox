class Admin::RoomsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy, :take_camshot]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end


  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        # if room_params[:scenario_id]
        #   scenario = Scenario.find(room_params[:scenario_id])
        #   @room.scenario = scenario if scenario
        # else
        #   @room.scenario = nil
        # end
        
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        # if room_params[:scenario_id].present?
        #   scenario = Scenario.find(room_params[:scenario_id])
        #   @room.scenario = scenario if scenario
        # else
        #   @room.scenario = nil
        # end

        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to admin_rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(
        :name, 
        :room_type, 
        :length, 
        :width, 
        :height, 
        scenario_ids: [])
    end
end
