class Admin::ScenariosController < Admin::AdminController
  before_action :authenticate_user!
  before_action :set_scenario, only: [:show, :edit, :update, :destroy, :run, :export]

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
    params = scenario_params
    if params[:condition_groups_attributes]
      params[:condition_groups_attributes].each do |key, group|
        if group[:conditions_attributes]
          group[:conditions_attributes].each do |skey, condition|
            if Condition.condition_types[condition[:condition_type]] == Condition.condition_types[:time_duration]
              if condition[:time_duration_hours] and condition[:time_duration_minutes]
                condition[:duration] = (condition[:time_duration_hours].to_i * 60) + condition[:time_duration_minutes].to_i
              elsif condition[:time_duration_hours]
                condition[:duration] = (condition[:time_duration_hours].to_i * 60)
              elsif condition[:time_duration_minutes]
                condition[:duration] = condition[:time_duration_minutes].to_i
              end
            end
          end
        end
      end
    end

    @scenario = Scenario.new(params)

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
    params = scenario_params
    if params[:condition_groups_attributes]
      params[:condition_groups_attributes].each do |key, group|
        if group[:conditions_attributes]
          group[:conditions_attributes].each do |skey, condition|
            if Condition.condition_types[condition[:condition_type]] == Condition.condition_types[:time_duration]
              if condition[:time_duration_hours] and condition[:time_duration_minutes]
                condition[:duration] = (condition[:time_duration_hours].to_i * 60) + condition[:time_duration_minutes].to_i
              elsif condition[:time_duration_hours]
                condition[:duration] = (condition[:time_duration_hours].to_i * 60)
              elsif condition[:time_duration_minutes]
                condition[:duration] = condition[:time_duration_minutes].to_i
              end
            end
          end
        end
      end
    end

    respond_to do |format|
      if @scenario.update(params)
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
    @scenario.run2(@scenario.rooms.first) if @scenario.rooms.first
    redirect_to admin_scenario_path(@scenario), notice: 'Scenario was successfully ran.'
  end


  def export
    json = @scenario.as_json(
      except: [
        :id,
        :created_at, 
        :updated_at, 
        :subject_id
      ], 
      include: {
        condition_groups: {
          except: [
            :id,
            :scenario_id,
            :created_at, 
            :updated_at
          ], 
          include: [
            conditions: {
              except: [
                :id,
                :condition_group_id,
                :last_duration_checked_at,
                :created_at, 
                :updated_at
              ]
            },
            operations: { 
              except: [
                :id,
                :device_id,
                :delay,
                :retries,
                :condition_group_id,
                :created_at, 
                :updated_at
              ]
            }
          ]
        }
      }
    )

    send_data(JSON.pretty_generate(json), filename: "#{@scenario.name}.json")
  end



  def import
    json_file = scenario_params[:json_file]

    scenario = Screnario.import(json_file.tempfile, scenario_params[:name])

    redirect_back fallback_location: admin_scenarios_url
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
        :json_file,
        condition_groups_attributes: [
          :id,
          :name,
          :scenario_id,
          :enabled,
          :_destroy,
          conditions_attributes: [
            :id, 
            :data_type_id,
            :duration,
            :time_duration_hours,
            :time_duration_minutes,
            :predicate,
            :target_value,
            :start_time,
            :end_time,
            :condition_type,
            :logic,
            :condition_group_id,
            :_destroy
          ],
          operations_attributes: [
            :id,
            :command, 
            :delay, 
            :retries, 
            :duration,
            :device_type, 
            :description, 
            :condition_group_id,
            :_destroy
          ]
        ]
      )
    end
end
