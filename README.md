# MAGICBOX

The MagicBox project is a set of hardware and software tools organized together that provides an open indoor growing platform. It cames from my obsession to automatize life while growing tropical plants. This kind of plant requires fine tuning and scheduling of their environmental parameters, as well as monitoring the overall health of the system. I built this software to assist me growing my own indoor garden and I publish new features along the way when I need them.

## How it works?

### Background

Tropical plants are usually grown in a controlled room or closet. Some typically use a mylar growbox inside what they grow their plants under full-spectrum lights, with air intraction, extraction and ventilation running on. Some components, lights for example, have to be scheduled at time to mimic the real lifecycle of the plants environment. Also, it is required to monitor environmental parameters like temperature and humidity to be be able to act on them as necessary. 

So I could have bought all the equipments to handle every of these aspects in the way that the indoor growing industry prevails. But heck no! I want everything centralized in a nice enclosure, all managed by a smart software while consuming my productsandwhile watching my grow being grown!

I recycled an old power inverter enclosure with 8 female 220V integrated plugs and I put every components I needed in it. Power plugs are managed by 5v relays through GPIO pins. I also connected DHT11 temperature and humidity sensors with home-made USB cables and connectors to monitor the room.

On the software side, I use a Ruby on Rails backend app that manages the whole system. From rooms, devices and sensors, to minimal grow management, the web interface provides all the tools I need for my indoor garden. 

### Features

* **Multiple rooms and devices management:** organize several grow rooms with their own devices and sensors all connected through GPIO pins on a Raspberry Pi
* **Condition-based growing scenarios:** you can build your own growing scenarios with user defined conditions to schedule and optimize your growing environment
* **Multiple grows management:** follow multiple grows simultaneously, move subjects (usually plants) from grow to grow and post detailed observations about them
* **Growing journal, calendar, todos, notifications and events** give you a global view of operations 
* Support for **pictures from mobile devices and webcams** 
* **Data, charts and statictics** help you to fine tune your setup along the way
* **Role-based users management:** organize your team, share and communicate to increase your productivity

## Requirements

### Hardware

* Raspberry Pi 4 - 4 GB RAM
* 8+ channels 5V relay module
* 220V AC
* 5V AC - 10 AMPS recommended
* DHT11 temperature/humidity sensor

### Software

* Raspbian 10 buster
* Ruby 2.6.5
* Rails 5.2.2

### Skills and tools

* Soldering, and tools coming with it
* Being a little confortable with electronic in general
* Mastering Linux is recommended, Ruby and RoR is a must

## Installation

### Dependencies

	sudo apt-get install nodejs libcurl4-openssl-dev imagemagick libmagickcore-dev libmagickwand-dev apache2 apache2-dev apt-transport-https ca-certificates postgresql libpq-dev postgresql-client

### Install RVM

	gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

	\curl -sSL https://get.rvm.io | bash

	source /home/pi/.rvm/scripts/rvm

### Install ruby

	rvm install ruby-2.7.1

	rvm use ruby-2.7.1 --default

### Update RubyGems

	gem update --system

	gem install bundler:2.1.4

### Install Passenger

	gem install passenger --no-document

	passenger-install-apache2-module

### Configure Apache virtual host

Create a new virtual host file:

	sudo nano /etc/apache2/sites-enabled/magicbox.domain.org.conf

With the following content, or alike:

	  ServerName magicbox.domain.org

	  <VirtualHost magicbox.domain.org:80 192.168.1.10:80>
	    # Tell Apache and Passenger where your app's 'public' directory is
	    DocumentRoot /home/pi/magicbox/public

	    PassengerRuby /home/pi/.rvm/gems/ruby-2.7.1/wrappers/ruby

	    # Relax Apache security settings
	    <Directory /home/pi/magicbox/public>
	      Allow from all
	      Options -MultiViews
	      # Uncomment this if you're on Apache >= 2.4:
	      Require all granted
	    </Directory>
	    RewriteEngine on
	    RewriteCond %{SERVER_NAME} =magicbox.domain.org
	    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
	  </VirtualHost>

### Database

	cd magicbox/

	RAILS_ENV=production bundle exec rake db:create
	RAILS_ENV=production bundle exec rake db:migrate
	RAILS_ENV=production bundle exec rake db:seed

### Run once

	cd magicbox/

	RAILS_ENV=production rails s

## Basic configuration

With the `rake db:seed` command executed earlier, some presets has been populated into the database already.

### GPIO setup


## API Usage

MagicBox provides a RESTful API to interact with over HTTP. Once MagicBox is installed, the API documentation is available at `http://localhost:3000/apidoc`.
