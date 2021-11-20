require 'onesignal'

OneSignal.configure do |config|
  config.app_id = ENV['ONESIGNAL_APP_ID']
  config.api_key = ENV['ONESIGNAL_API_KEY']
  config.active = true
end