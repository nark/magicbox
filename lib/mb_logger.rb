# class MBLogger < Logger
#   # def format_message(severity, timestamp, progname, msg)
#   #   "#{timestamp.to_formatted_s(:db)} #{severity} #{progname} #{msg}\n"
#   # end
# end

logfile = File.open("#{Rails.root}/log/magicbox.log", 'a')
logfile.sync = true

loggger = Logger.new(logfile)
loggger.formatter = Logger::Formatter.new
MB_LOGGER = ActiveSupport::TaggedLogging.new(loggger)