class NotificationsController < ApplicationController
	before_action :authenticate_user!

	add_breadcrumb "Notifications"
	
	def index
		@notifications = current_user.notifications.paginate(page: params[:page], per_page: 100)

		current_user.mark_notifications_as_read
	end

	def destroy
		@notification = Notification.find(params[:id])

		@notification.destroy

		redirect_to admin_notifications_url, notice: 'Notification was successfully destroyed.'
	end


  def clear_all
  	Notification.all.each do |notification|
  		notification.destroy
  	end
  	
    redirect_to request.referrer, notice: 'All notifications successfully deleted.'
  end
end