class Api::V1::PushDevicesController < ActionController::API
	before_action :set_user

	def create
    device = PushDevice.create(user_id: @user.id, device_id: push_device_params[:device_id])
    render json: @user
	end

private
	def set_user
		@user = User.find(params[:user_id])
	end

	def push_device_params
      params.require(:push_device).permit(:device_id)
	end
end