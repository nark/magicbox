class ObservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grow, only: [:index, :new, :show, :edit, :create, :update, :destroy]
  before_action :set_subject, only: [:index, :new, :show, :edit, :create, :update, :destroy]
  before_action :set_observation, only: [:show, :edit, :update, :destroy]

  # GET /observations
  # GET /observations.json
  def index
    @observations = Observation.all
  end

  # GET /observations/1
  # GET /observations/1.json
  def show
    commontator_thread_show @observation
  end

  # GET /observations/new
  def new
    add_breadcrumb "New observation"

    @observation = Observation.new

    if current_user.observations.last 
      current_user.observations.last.resource_datas.each do |rd|
        @observation.resource_datas.build(
          resource_id: rd.resource_id,
          observation_id: rd.observation_id,
          value: rd.value,
          unit: rd.unit,
          category_id: rd.resource.category_id
        ) 
      end
    end
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
        message = "New observation has been created by <b>#{current_user.username}</b>"

        Event.create!(event_type: :action, message: message, eventable: @observation, user_id: current_user.id)

        if @subject
          format.html { redirect_to [@grow, @subject], notice: 'Observation was successfully created.' }
        else
          format.html { redirect_to @grow, notice: 'Observation was successfully created.' }
        end

        
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
        format.html { redirect_to [@grow, @subject], notice: 'Observation was successfully updated.' }
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
      format.html { redirect_to @grow, notice: 'Observation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_grow
      if params[:grow_id].present?
        @grow = Grow.find(params[:grow_id])

        add_breadcrumb "Grow ##{@grow.id}", @grow

      elsif params[:observation] and observation_params[:grow_id].present?
        @grow = Grow.find(observation_params[:grow_id])

        add_breadcrumb "Grow ##{@grow.id}", @grow
      end
    end

    def set_subject
      if params[:subject_id].present?
        @subject = Subject.find(params[:subject_id])

        add_breadcrumb "#{@subject.name}", [@grow, @subject]
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_observation
      @observation = Observation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observation_params
      params.require(:observation).permit(
        :user_id, 
        :grow_id, 
        :room_id, 
        :subject_id, 
        :body, 
        :water, 
        :nutrients,
        subject_ids: [],
        pictures: [],
        resource_datas_attributes: [
          :id,
          :subject_id,
          :observation_id,
          :resource_id,
          :value,
          :unit,
          :_destroy
        ],
        issues_attributes: [
          :id,
          :subject_id,
          :observation_id,
          :resource_id,
          :issue_type,
          :issue_status,
          :severity,
          :_destroy
        ])
    end
end
