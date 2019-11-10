#!/usr/bin/python

import time
import sys
import sqlite3
from sqlite3 import Error
from RPi import GPIO
from RPLCD.gpio import CharLCD


def create_connection(db_file):

  try:
    conn = sqlite3.connect(db_file)
    return conn
  except Error as e:
    print(e)

  return None



GPIO.setmode(GPIO.BOARD)
GPIO.setup(33,GPIO.OUT)
GPIO.setup(31,GPIO.OUT)
GPIO.setup(29,GPIO.OUT)
GPIO.setup(23,GPIO.OUT)

lcd=CharLCD(numbering_mode=GPIO.BOARD, pin_rs=36, pin_e=38, rows=2, cols=16, pins_data=[37,35,33,31])

try:
    conn = create_connection("/home/pi/magicbox/db/production.sqlite3")
    cur = conn.cursor()

    sleep_time=7
    cursor_x=2

    cur.execute("SELECT * FROM samples WHERE data_type_id = 1 ORDER BY created_at DESC LIMIT 1")
    temp = cur.fetchone()

    cur.execute("SELECT * FROM samples WHERE data_type_id = 2 ORDER BY created_at DESC LIMIT 1")
    hum = cur.fetchone()

    lcd.clear()
    lcd.cursor_pos = (0, cursor_x)

    lcd.write_string(u'TEMP: ' + temp[3] + 'C')
    lcd.cursor_pos = (1, cursor_x)
    lcd.write_string(u'HUM: ' + hum[3] + '%')

    time.sleep(sleep_time)



    cur.execute("SELECT * FROM samples WHERE data_type_id = 3 ORDER BY created_at DESC LIMIT 1")
    soil = cur.fetchone()

    cur.execute("SELECT * FROM samples WHERE data_type_id = 4 ORDER BY created_at DESC LIMIT 1")
    lux = cur.fetchone()

    lcd.clear()
    lcd.cursor_pos = (0, cursor_x)

    lcd.write_string(u'SOIL: ' + soil[3] + u'%')
    lcd.cursor_pos = (1, cursor_x)
    lcd.write_string(u'WAT: ' + lux[3] + u'%')

    time.sleep(sleep_time)



    cur.execute("SELECT * FROM devices WHERE pin_number = 1 LIMIT 1")
    r1 = cur.fetchone()

    cur.execute("SELECT * FROM devices WHERE pin_number = 2 LIMIT 1")
    r2 = cur.fetchone()

    lcd.clear()
    lcd.cursor_pos = (0, cursor_x)

    lcd.write_string(u'R1: ' + (u'ON' if r1[2] == 1 else u'OFF'))
    lcd.cursor_pos = (1, cursor_x)
    lcd.write_string(u'R2: ' + (u'ON' if r2[2] == 1 else u'OFF'))

    time.sleep(sleep_time)
    

    cur.execute("SELECT * FROM devices WHERE pin_number = 3 LIMIT 1")
    r3 = cur.fetchone()

    cur.execute("SELECT * FROM devices WHERE pin_number = 4 LIMIT 1")
    r4 = cur.fetchone()

    lcd.clear()
    lcd.cursor_pos = (0, cursor_x)

    lcd.write_string(u'R3: ' + (u'ON' if r3[2] == 1 else u'OFF'))
    lcd.cursor_pos = (1, cursor_x)
    lcd.write_string(u'R4: ' + (u'ON' if r4[2] == 1 else u'OFF'))

    time.sleep(sleep_time)


except:
  pass

finally:
  GPIO.cleanup()
