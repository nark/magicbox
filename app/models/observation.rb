class Observation < ApplicationRecord
	belongs_to :user
	belongs_to :grow
	belongs_to :room, optional: true

	has_many :observations_subjects
	has_many :subjects, through: :observations_subjects

	has_many :resource_datas
	accepts_nested_attributes_for :resource_datas, allow_destroy: true, :reject_if => proc { |attributes| attributes['value'].blank? }

	has_many :issues
	accepts_nested_attributes_for :issues, allow_destroy: true

	has_many_attached :pictures

	validates :body, presence: true

	def start_date
		created_at
	end

	def end_date
		created_at + 1.hour
	end

	def text
		body
	end

	def url
		Rails.application.routes.url_helpers.grow_observation_path(grow, self)
	end
end
