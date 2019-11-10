#!/bin/ruby

require 'rubygems'
require 'rubyserial'
require 'active_record'
require 'sqlite3'

# configure environment
if !ENV['RAILS_ENV'] or ENV['RAILS_ENV'].length == 0
	ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
end
require './config/environment.rb'


def readString(sp)
	#sp.flush()

	string = ""
	brek = false
	c = nil

	while !brek
		c = sp.read(1)
		string << c
		if c == '\n'
			brek = true
			break
		end
	end

	return nil if string.length == 0
	return string
end


def writeString(sp)
	sp.write(c)
	#sp.flush()
end


# connect to database
db = YAML.load_file("./config/database.yml")[ENV['RAILS_ENV']]
ActiveRecord::Base.establish_connection(db)


# create TTY
serialport = Serial.new '/dev/ttyACM0', 9600, 8, :even


# write command to the Arduino serial port
command = ARGV[0]
serialport.write(command)

sleep(1)

# read result to the Arduino serial port
json_string = readString(serialport)
puts json_string

# check for errors
if !json_string
	puts "ERROR: Empty response"
	exit
end

if json_string.start_with? "UNKNOW"
	puts "ERROR: Unknow input command: #{command}"
	exit
end

hash = JSON.parse json_string

if !hash
	puts "ERROR: JSON parse failed"
	exit
end

# insert sample into database
hash.each do |k,v|
	dataType = DataType.find_by_name(k)

	puts dataType

	# if dataType
	# 	Sample.create(
	# 		product_reference: v['sensor'],
	# 		data_type_id: dataType.id,
	# 		value: v['value'],
	# 		unit: v['unit']
	# 	)
	# else 
	# 	puts "WARN: Can't find data type ID for #{k} sensor, ignoring"
	# end
end