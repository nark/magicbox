class Subject < ApplicationRecord
	belongs_to :grow
	belongs_to :room

	has_many :observations, dependent: :delete_all
	has_many :scenarios

	def name_with_grow
		"#{self.name} [Grow##{self.grow_id}]"
	end

	def generate_qr(size)
	  require 'barby'
	  require 'barby/barcode'
	  require 'barby/barcode/qr_code'
	  require 'barby/outputter/png_outputter'

	  barcode = Barby::QrCode.new("http://magicbox.local/admin/grows/#{self.grow.id}/subjects/#{self.id}/observations/new", level: :q, size: 6)
	  base64_output = Base64.encode64(barcode.to_png({ xdim: size }))
	  "data:image/png;base64,#{base64_output}"
	end
end
