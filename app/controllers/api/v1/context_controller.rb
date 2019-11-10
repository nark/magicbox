class Api::V1::ContextController < ApiController
	resource_description do
    short 'Context of the app'
    description "The context define a general dictionnary of data that are used at application first launch.."
    formats ['json']
    deprecated false
  end

  api :GET, '/v1/context', "Get the app context"
	def index
		render json: {
			devices: Device.all.as_json(include: :data_types),
			data_types: DataType.all.as_json
		}
	end
end