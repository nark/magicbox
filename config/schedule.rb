# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# # read sensors
# every 5.minute do
#   command "/usr/bin/python /home/pi/magicbox/scripts/arduino.py COMMAND:READ_SENSORS"
# end

# # check scenario
# every 15.minute do
#   runner "Scenario.check"
# end

# every 1.day, at: '2:00 am' do
#   command "/usr/bin/python /home/pi/magicbox/scripts/arduino.py COMMAND:DIGITAL_WRITE:2:0"
# end

# every 1.day, at: '8:00 am' do
#   command "/usr/bin/python /home/pi/magicbox/scripts/arduino.py COMMAND:DIGITAL_WRITE:2:1"
# end

# # start VMC every 15 min for 5 min between 2pm and 8pm
# every '*/15 2-8 * * *' do
# 	command "/usr/bin/python /home/pi/magicbox/scripts/arduino.py COMMAND:DIGITAL_WRITE:7:1 && sleep 300 && /usr/bin/python /home/pi/magicbox/scripts/arduino.py COMMAND:DIGITAL_WRITE:7:0"
# end

every 4.minute do
	runner "Scenario.run"
end