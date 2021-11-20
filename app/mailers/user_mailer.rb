class UserMailer < ApplicationMailer 
	add_template_helper(ApplicationHelper)

	default from: Setting.app_email
	
  def notification_email
    @user = params[:user]
    @notification = params[:notification]

    mail(to: @user.email, subject: @notification.notifiable.email_subject)
  end
end
