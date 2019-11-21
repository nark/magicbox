class Admin::ObservationsController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_grow, only: [:index, :new, :show, :edit, :update, :destroy]
  before_action :set_subject, only: [:index, :new, :show, :edit, :update, :destroy]
  before_action :set_observation, only: [:show, :edit, :update, :destroy]

  # GET /observations
  # GET /observations.json
  def index
    @observations = Observation.all
  end

  # GET /observations/1
  # GET /observations/1.json
  def show
  end

  # GET /observations/new
  def new
    @observation = Observation.new
    @observation.water = 0
    @observation.nutrients = 0
  end

  # GET /observations/1/edit
  def edit
  end

  # POST /observations
  # POST /observations.json
  def create
    @observation = Observation.new(observation_params)

    respond_to do |format|
      if @observation.save
        format.html { redirect_to [:admin, @grow, @subject], notice: 'Observation was successfully created.' }
        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observations/1
  # PATCH/PUT /observations/1.json
  def update
    respond_to do |format|
      if @observation.update(observation_params)
        format.html { redirect_to [:admin, @grow, @subject], notice: 'Observation was successfully updated.' }
        format.json { render :show, status: :ok, location: @observation }
      else
        format.html { render :edit }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observations/1
  # DELETE /observations/1.json
  def destroy
    @observation.destroy
    respond_to do |format|
      format.html { redirect_to observations_url, notice: 'Observation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_grow
      @grow = Grow.find(params[:grow_id])

      add_breadcrumb "Grow ##{@grow.id}", [:admin, @grow]
    end

    def set_subject
      @subject = Subject.find(params[:subject_id])

      add_breadcrumb "#{@subject.name}", [:admin, @grow, @subject]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_observation
      @observation = Observation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observation_params
      params.require(:observation).permit(:user_id, :grow_id, :room_id, :subject_id, :body, :water, :nutrients)
    end
end
