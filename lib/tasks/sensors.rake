namespace :sensors do
	desc "Get sensors value"
  task :read => :environment do
  	Device.all.each do |d|
  		if d.sensor?
  			d.query_sensor
  		end
  	end
  end

  task :lcd => :environment do
  # 	require 'charlcd'

		# char_lcd = CharLcd.new
		# #char_lcd.begin(16, 2)
		# char_lcd.message("First Line\nSecond Line")
		# char_lcd.clean_pins()
  end
end
