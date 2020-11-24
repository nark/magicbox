class Resource < ApplicationRecord
	belongs_to :category
	has_many :resource_datas
end
