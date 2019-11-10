class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true
  skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' }

	def after_sign_in_path_for(resource)
    admin_dashboard_path
  end
end
