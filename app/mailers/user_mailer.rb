class UserMailer < ApplicationMailer 
	default from: 'no-reply@magicbox.read-write.fr'
	
  def notification_email
    @user = params[:user]
    @notification = params[:notification]

    @url  = "#{Rails.application.config.action_mailer.default_url_options[:protocol]}://#{Rails.application.config.action_mailer.default_url_options[:host]}"

    mail(to: @user.email, subject: @notification.alert.title)
  end
end
