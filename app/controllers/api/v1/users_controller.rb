class Api::V1::UsersController < ApiController
	def index
		if params.has_key? :email
			@user = User.where(email: params[:email]).first

			if @user
				render json: [@user] and return
			end
		end

		head :no_content
	end
end