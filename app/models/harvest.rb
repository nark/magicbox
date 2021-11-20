class Harvest < ApplicationRecord
	belongs_to :grow

	has_many :batches

	validates :harvested_trim_weight, presence: true
	validates :harvested_waste_weight, presence: true
	validates :harvested_bud_weight, presence: true

	def remaining_weight_for_batch_type(batch_type)
		consumed = batches.where(batch_type: batch_type).sum(:total_weight)

		if batch_type == :trim
			return dry_trim_weight - consumed <= 0 ? 0 : dry_trim_weight - consumed
		elsif batch_type == :bud
			return dry_bud_weight - consumed <= 0 ? 0 : dry_bud_weight - consumed
		end
		return 0
	end


	def trim_batched
		batches.where(batch_type: :trim).sum(:total_weight)
	end


	def bud_batched
		batches.where(batch_type: :bud).sum(:total_weight)
	end


	def total_trim
		total = 0
		total += harvested_trim_weight if harvested_trim_weight
		total += dry_trim_weight if dry_trim_weight
		total
	end

	def total_waste
		total = 0
		total += harvested_waste_weight if harvested_waste_weight
		total	
	end

	def total_bud
		total = 0
		total += harvested_bud_weight if harvested_bud_weight
		total += dry_bud_weight if dry_bud_weight
		total	
	end


	def total_wet
		total_wet = 0
		total_wet += harvested_trim_weight if harvested_trim_weight
		total_wet += harvested_waste_weight if harvested_waste_weight
		total_wet += harvested_bud_weight if harvested_bud_weight
		total_wet
	end

	def total_dry
		total_dry = 0
		total_dry += dry_trim_weight if dry_trim_weight
		total_dry += dry_bud_weight if dry_bud_weight
		total_dry
	end
end
	