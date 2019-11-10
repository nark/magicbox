import os
import glob
import serial
import time
import io
import json
import sys
import requests


def data_type_id(for_key):
	if (key == "temperature"):
		return 1
	elif (key == "humidity"):
		return 2
	elif (key == "soil_moisture"):
		return 3
	elif (key == "water_level"):
		return 4

# get JSON from serial port
def read_serial(ser, len):
  while True:
    if ser.inWaiting() > 0:
      break;
    time.sleep(0.5)
  return ser.readline()

# vars
ts = str(int(time.time()))
command = sys.argv[1]
device = "/dev/ttyACM0"
rate = 9600
ser = serial.Serial(device, rate, timeout=1)
time.sleep(2) #wait for the Arduino to init
# The GET_JSON command is exposed by the Arduino board on the serial port.
# By sending this command, the board will fetch all the sensors and
# return a JSON object

if command.startswith("COMMAND:"):
	comps = command.split(":")

	if comps >= 2:
		ser.write(command) 
		sensor_json_str = read_serial(ser, 32)

		if comps[1] == "READ_SENSORS":
			new_json_data 	= json.loads(sensor_json_str)

			for key, value in new_json_data.iteritems():
				sample_data = {
					"sample": {
						"product_reference": value['sensor'],
						"data_type_id": data_type_id(key),
						"value": str(value['value']),
						"unit": value['unit'],
					}
				}

				url = 'http://localhost:3000/api/v1/samples'
				headers = {'content-type': 'application/json'}
				response = requests.post(url, data=json.dumps(sample_data), headers=headers)

		print sensor_json_str




