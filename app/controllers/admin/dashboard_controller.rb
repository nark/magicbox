class Admin::DashboardController < Admin::AdminController
	before_action :authenticate_user!

	add_breadcrumb "Dashboard"

	def gpio
		add_breadcrumb "GPIO"

		@gpio_left = {
			'1':  {name: "3.3V", 	 gpio: nil, plug: nil },
			'3':  {name: "GPIO2",  gpio: 2, plug: nil  		},
			'5':  {name: "GPIO3",  gpio: 3, plug: nil  		},
			'7':  {name: "GPIO4",  gpio: 4, plug: nil  		},
			'9':  {name: "GND", 	 gpio: nil, plug: nil  	},
			'11': {name: "GPIO17", gpio: 17, plug: "USB1" },
			'13': {name: "GPIO27", gpio: 27, plug: "USB2" },
			'15': {name: "GPIO22", gpio: 22, plug: "USB3" },
			'17': {name: "3.3V", 	 gpio: nil, plug: nil  	},
			'19': {name: "GPIO10", gpio: 10, plug: nil  	},
			'21': {name: "GPIO9",  gpio: 9, plug: nil  		},
			'23': {name: "GPIO11", gpio: 11, plug: nil  	},
			'25': {name: "GND", 	 gpio: nil, plug: nil  	},
			'27': {name: "DNC", 	 gpio: nil, plug: nil   },
			'29': {name: "GPIO5",  gpio: 5, plug: "B1"  	},
			'31': {name: "GPIO6",  gpio: 6, plug: "B2"  	},
			'33': {name: "GPIO13", gpio: 13, plug: nil  	},
			'35': {name: "GPIO19", gpio: 19, plug: nil  	},
			'37': {name: "GPIO26", gpio: 26, plug: nil  	},
			'39': {name: "GND", 	 gpio: nil, plug: nil  	}
		}

		@gpio_right = {
			'2':  {name: "5V",   	 gpio: nil, plug: nil  	},
			'4':  {name: "5V", 		 gpio: nil, plug: nil  	},
			'6':  {name: "GND", 	 gpio: nil, plug: nil  	},
			'8':  {name: "GPIO14", gpio: 14, plug: nil  	},
			'10': {name: "GPIO15", gpio: 15, plug: nil  	},
			'12': {name: "GPIO18", gpio: 18, plug: "A1"  	},
			'14': {name: "GND", 	 gpio: nil, plug: nil  	},
			'16': {name: "GPIO23", gpio: 23, plug: "A2"  	},
			'18': {name: "GPIO24", gpio: 24, plug: "A3"  	},
			'20': {name: "GND", 	 gpio: nil, plug: nil  	},
			'22': {name: "GPIO25", gpio: 25, plug: "A4"  	},
			'24': {name: "GPIO8",  gpio: 8, plug: nil 		},
			'26': {name: "GPIO7",  gpio: 7, plug: nil  	 	},
			'28': {name: "DNC", 	 gpio: nil, plug: nil   },
			'30': {name: "GND", 	 gpio: nil, plug: nil  	},
			'32': {name: "GPIO12", gpio: 12, plug: "B3"  	},
			'34': {name: "GND", 	 gpio: nil, plug: nil  	},
			'36': {name: "GPIO16", gpio: 16, plug: "B4"  	},
			'38': {name: "GPIO20", gpio: 20, plug: nil  	},
			'40': {name: "GPIO21", gpio: 21, plug: nil  	}
		}
	end
end