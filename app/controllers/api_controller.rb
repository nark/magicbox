class ApiController < ActionController::API
	acts_as_token_authentication_handler_for User

	before_action do
    ActiveStorage::Current.host = request.base_url
  end

end