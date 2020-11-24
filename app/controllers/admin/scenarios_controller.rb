class Admin::ScenariosController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_scenario, only: [:show, :edit, :update, :destroy, :run]

  # GET /scenarios
  # GET /scenarios.json
  def index
    @scenarios = Scenario.all

    add_breadcrumb "Scenarios"
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
  end

  # GET /scenarios/new
  def new
    @scenario = Scenario.new
  end

  # GET /scenarios/1/edit
  def edit
    if @scenario.conditions.count == 0
      #condition = @scenario.conditions.build
      #condition.operations.build
    end
  end

  # POST /scenarios
  # POST /scenarios.json
  def create
    @scenario = Scenario.new(scenario_params)

    respond_to do |format|
      if @scenario.save
        format.html { redirect_to admin_scenario_path(@scenario), notice: 'Scenario was successfully created.' }
        format.json { render :show, status: :created, location: @scenario }
      else
        format.html { render :new }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scenarios/1
  # PATCH/PUT /scenarios/1.json
  def update
    respond_to do |format|
      if @scenario.update(scenario_params)
        format.html { redirect_to admin_scenario_path(@scenario), notice: 'Scenario was successfully updated.' }
        format.json { render :show, status: :ok, location: @scenario }
      else
        format.html { render :edit }
        format.json { render json: @scenario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    @scenario.destroy
    respond_to do |format|
      format.html { redirect_to admin_scenarios_url, notice: 'Scenario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def run
    @scenario.run2
    redirect_to admin_scenario_path(@scenario), notice: 'Scenario was successfully ran.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scenario
      @scenario = Scenario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scenario_params
      params.require(:scenario).permit(
        :enabled,
        :name, 
        :subject_id, 
        :description, 
        crons_attributes: [
          :id, 
          :cron_type,
          :scenario_id,
          :device_id,
          :predicate,
          :command,
          :period,
          :start_time,
          :end_time,
          :delay,
          :repeats,
          :duration,
          :last_exec_time,
          :time_value,
          :_destroy,
        ],
        conditions_attributes: [
          :id, 
          :name,
          :data_type_id,
          :predicate,
          :target_value,
          :start_time,
          :end_time,
          :scenario_id,
          :_destroy,
          operations_attributes: [
            :id,
            :command, 
            :delay, 
            :retries, 
            :device_id, 
            :description, 
            :condition_id,
            :_destroy
          ]
      ])
    end
end
