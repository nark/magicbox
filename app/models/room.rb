class Room < ApplicationRecord
	attr_accessor :scenario_id

	has_many :subjects
	has_many :devices, dependent: :delete_all
	has_many :events, dependent: :delete_all

	has_many :observations, through: :subjects

	has_many :samples, through: :devices
	
	has_one :room_scenario, dependent: :destroy
	has_one :scenario, through: :room_scenario

	enum room_type: {
		box: 				0,
		closet: 		1,
		room: 			2,
		greenhouse: 3
	}

	has_many_attached :camshots


	def active_subjects
		subjects.joins(:grow).where.not("grows.grow_status": [:done, :aborted])
	end


	def total_watts
		w = 0

		devices.each do |device|
			if device.watts && device.watts > 0.0
				w += device.watts
			end
		end

		return w.round(2)
	end


	def kwh_day
		kwh = 0

		scenario.condition_groups.each do |group|
			group.operations.each do |operation|
				if operation.command == "start"
					running_time = 24

					group.conditions.where(condition_type: :date).each do |condition|
						running_time = (condition.end_time - condition.start_time).abs / 3600
					end

					if running_time > 0
						puts "#{operation.device.name} : #{running_time}"

						kwh += running_time * operation.device.watts / 1000
					end
				end
			end
		end

		return kwh.round(2)
	end


	def kwh_month
		kd = kwh_day
		return (kd * 30).round(2) if kd > 0
		return 0
	end


	def take_camshot
		# get camera device
		# exit if no camera device
		camera_device = devices.where(device_type: :camera).first
		return if !camera_device

		# temp path
		tmp_name = "camshot-image-#{Time.now.to_i}"
  	tmp_image_path = "/tmp/#{tmp_name}.jpeg"

  	# capture image from webcam with fswebcam
    `/usr/bin/fswebcam -d /dev/#{camera_device.product_reference} --flip v --no-banner -r 384x288 #{tmp_image_path}`

    # add the image to room camshots
		self.camshots.attach io: File.open(tmp_image_path), filename: "image-#{Time.now.strftime("%s%L")}.jpeg"

    # delete tmp file 
  	File.delete(tmp_image_path) if File.exist?(tmp_image_path)
	end


	def is_dark
		require 'rmagick'
		active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
		path = active_storage_disk_service.send(:path_for, self.camshots.last.blob.key)

		img = Magick::Image::read(path).first
		puts img.channel_mean

		return true if img.channel_mean[0] <= 7000 and img.channel_mean[1] <= 1000
		return false
	end
end
