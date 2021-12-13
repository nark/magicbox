class SamplesController < ApplicationController
	before_action :authenticate_user!

	add_breadcrumb "Statistics"
	
	def index	

	end


	def general
		@data_types_samples = {}

		@date_filter = "today"
		@date_filter = params[:date_filter] if params[:date_filter]

		Sample.unscoped.distinct.where.not(product_reference: "dht11").pluck(:product_reference).each do |product_reference|
			data = DataType.all.map { |data_type| 
				samples = data_type.samples
				now = Time.zone.now

				if @date_filter.to_s == "today"
					samples = samples.where("samples.created_at": now.beginning_of_day..now.end_of_day)
				elsif @date_filter.to_s == "last_week"
					samples = samples.where("samples.created_at": (now-7.days)..now.end_of_day)
				elsif @date_filter.to_s == "last_month"
					samples = samples.where("samples.created_at": (now-1.month)..now.end_of_day)
				elsif @date_filter.to_s == "last_year"
					samples = samples.where("samples.created_at": (now-12.month)..now.end_of_day)
				elsif @date_filter.to_s == "all_time"
					samples = samples
				else
					puts "else"
					samples = samples.where("samples.created_at": now.beginning_of_day..now.end_of_day)
				end

				samples = samples.where(product_reference: product_reference).order(created_at: :desc)
				{
					name: data_type.name, 
			    data: samples.map { |e| [e.created_at, e.value]  }, 
			    color: samples.first.html_color
				} if samples.first
			}.compact

			@data_types_samples[product_reference] = data

		end
	end


	def rooms
		@data_types_samples = {}

		@date_filter = "today"
		@date_filter = params[:date_filter] if params[:date_filter]

		Room.all.each do |room|
			data = DataType.all.map { |data_type| 
				samples = room.samples.where(data_type_id: data_type.id)
				now = Time.zone.now

				if @date_filter.to_s == "today"
					samples = samples.where("samples.created_at": now.beginning_of_day..now.end_of_day)
				elsif @date_filter.to_s == "last_week"
					samples = samples.where("samples.created_at": (now-7.days)..now.end_of_day)
				elsif @date_filter.to_s == "last_month"
					samples = samples.where("samples.created_at": (now-1.month)..now.end_of_day)
				elsif @date_filter.to_s == "last_year"
					samples = samples.where("samples.created_at": (now-12.month)..now.end_of_day)
				elsif @date_filter.to_s == "all_time"
					samples = samples
				else
					puts "else"
					samples = samples.where("samples.created_at": now.beginning_of_day..now.end_of_day)
				end

				samples = samples.order(created_at: :desc)
				{
					name: data_type.name, 
			    data: samples.map { |e| [e.created_at, e.value]  }, 
			    color: samples.first.html_color
				} if samples.first
			}.compact

			@data_types_samples[room.name] = data
		end
	end


	def harvest
		@data_types_samples = {}

		@date_filter = "today"
		@date_filter = params[:date_filter] if params[:date_filter]

		@data_types_samples = [:harvested_trim_weight, :harvested_waste_weight, :harvested_bud_weight, :dry_bud_weight, :dry_trim_weight].map { |k|
		    {name: k.to_s.humanize, data: Harvest.joins(:grow).order("harvests.created_at ASC").group('harvests.created_at', 'grows.description').sum(k)}
		}
	end
end