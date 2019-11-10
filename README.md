# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## Disable auto-reset on serial connexion with the Arduino:

	stty -F /dev/ttyACM0 -hupcl

Source: https://raspberrypi.stackexchange.com/questions/9695/disable-dtr-on-ttyusb0/31298