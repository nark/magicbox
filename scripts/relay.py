#!/usr/bin/env python
import sys
import RPi.GPIO as GPIO
from time import sleep

# The script as below using BCM GPIO 00..nn numbers
GPIO.setmode(GPIO.BCM)

relays = {
	'1': 18, 
	'2': 23,
	'3': 24,
	'4': 25
}

try:
	relay  = sys.argv[1]
	action = sys.argv[2]

	pin  = relays[relay]

	# Set relay pins as output
	GPIO.setup(pin, GPIO.OUT)
	GPIO.output(pin, int(action))

	sleep(4)  

except KeyboardInterrupt: # If CTRL+C is pressed, exit cleanly:
  print("Keyboard interrupt")

except:
  print("some error") 

finally:
  print("clean up") 
  #GPIO.cleanup()
  #GPIO.cleanup() # cleanup all GPIO 

