#!/usr/bin/python

import time
import sys
import psycopg2
from RPi import GPIO
from RPLCD.gpio import CharLCD


def create_connection():
  return psycopg2.connect(host="localhost",database="magicbox_production", user="postgres", password="magicbox")

conn = create_connection()
cur = conn.cursor()

cur.execute("SELECT * FROM samples WHERE data_type_id = 1 ORDER BY created_at DESC LIMIT 1")
temp = cur.fetchone()

cur.execute("SELECT * FROM samples WHERE data_type_id = 2 ORDER BY created_at DESC LIMIT 1")
hum = cur.fetchone()

print(temp[3])
print(hum[3])



lcd = CharLCD(numbering_mode=GPIO.BOARD, rows=2, cols=16, pin_rs=36, pin_e=38, pins_data=[37,35,33,31])

lcd.clear()
time.sleep(2)

lcd.cursor_pos = (0, 0)
lcd.write_string("TEMP: " + str(temp[3]))
time.sleep(1)

# lcd.cursor_pos = (1, 0)
# lcd.write_string("HUM:  " + str(hum[3]))
# time.sleep(1)

#GPIO.cleanup()
