class Api::V1::ObservationsController < ApiController	
  before_action :set_observation, only: [:update]
  
	def index
    if params.has_key? "subject_id"
      @subject = Subject.find(params[:subject_id])
      @observations = @subject.observations.order(created_at: :desc).limit(100)
    else
      @observations = Observation.all.order(created_at: :desc).limit(100)
    end

		render json: @observations, include: [
    	:user,
			:subjects => {:methods => [:strain_name]}
		], methods: [
			:text, 
			:start_date, 
			:end_date,
			:pictures_url
		]
	end

	def create
		@observation = Observation.new(observation_params)

		@observation.user = current_user if @observation.user == nil

    if @observation.save!
      render json: @observation, include: [
      :user,
      :subjects => {:methods => [:strain_name]}
    ], methods: [
      :text, 
      :start_date, 
      :end_date,
      :pictures_url
    ], status: :created
    else
      render json: @observation.errors, status: :unprocessable_entity
    end
	end


  def update
    #@observation.user = current_user if @observation.user == nil

    if @observation.update!(observation_params)
      render json: @observation, include: [
      :user,
      :subjects => {:methods => [:strain_name]}
    ], methods: [
      :text, 
      :start_date, 
      :end_date,
      :pictures_url
    ], status: :created
    else
      render json: @observation.errors, status: :unprocessable_entity
    end
  end


private
  def set_observation
    @observation = Observation.find(params[:id])
  end

	def observation_params
      params.require(:observation).permit(
        :user_id, 
        :grow_id, 
        :room_id, 
        :subject_id, 
        :body, 
        :water, 
        :nutrients,
        :updated_at,
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