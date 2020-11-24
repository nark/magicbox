class Notification < ApplicationRecord
	belongs_to :alert
	belongs_to :user
end
