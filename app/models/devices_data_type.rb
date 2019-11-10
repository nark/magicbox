class DevicesDataType < ApplicationRecord
	belongs_to :device, class_name: "Device"
	belongs_to :data_type, class_name: "DataType"
end
