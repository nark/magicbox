class Subject < ApplicationRecord
	belongs_to :grow
	belongs_to :room

	has_many :observations_subjects
	has_many :observations, through: :observations_subjects, dependent: :delete_all
	has_many :resource_datas, through: :observations
	has_many :issues, through: :observations
	has_many :scenarios

	def name_with_grow
		"#{self.name} [Grow##{self.grow_id}]"
	end

	def generate_qr(size)
	  require 'barby'
	  require 'barby/barcode'
	  require 'barby/barcode/qr_code'
	  require 'barby/outputter/png_outputter'

	  barcode = Barby::QrCode.new("#{Setting.app_hostname}/grows/#{self.grow.id}/subjects/#{self.id}/observations/new", level: :q, size: 6)
	  "data:image/png;base64,#{Base64.strict_encode64(barcode.to_png({ xdim: size }))}"
	end

	def fullname
		"##{id} - #{name}"
	end
end
