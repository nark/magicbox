class Admin::GrowsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_grow, only: [:show, :edit, :update, :destroy, :print_qr]

  # GET /grows
  # GET /grows.json
  def index
    @grows = Grow.all

    add_breadcrumb "Grows"
  end

  # GET /grows/1
  # GET /grows/1.json
  def show
  end

  # GET /grows/new
  def new
    @grow = Grow.new

    add_breadcrumb "Grows", admin_grows_path
    add_breadcrumb "New"
  end

  # GET /grows/1/edit
  def edit
    add_breadcrumb "Edit"
  end

  # POST /grows
  # POST /grows.json
  def create
    @grow = Grow.new(grow_params)

    respond_to do |format|
      if @grow.save
        # create subjects
        @grow.number_of_subjects.times do |i|
          room = Room.find(params[:room])
          Subject.create(name: "Subject #{i+1}", grow_id: @grow.id, room_id: room.id) if room
        end

        format.html { redirect_to [:admin, @grow], notice: 'Grow was successfully created.' }
        format.json { render :show, status: :created, location: @grow }
      else
        format.html { render :new }
        format.json { render json: @grow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grows/1
  # PATCH/PUT /grows/1.json
  def update
    respond_to do |format|
      if @grow.update(grow_params)
        format.html { redirect_to [:admin, @grow], notice: 'Grow was successfully updated.' }
        format.json { render :show, status: :ok, location: @grow }
      else
        format.html { render :edit }
        format.json { render json: @grow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grows/1
  # DELETE /grows/1.json
  def destroy
    @grow.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, :grows], notice: 'Grow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print_qr
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grow
      @grow = Grow.find(params[:id])

      add_breadcrumb "Grow ##{@grow.id}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grow_params
      params.require(:grow).permit(:grow_status, :description, :start_date, :end_date, :substrate, :flowering, :number_of_subjects)
    end
end
