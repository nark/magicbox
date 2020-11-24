class Admin::WeeksController < Admin::AdminController
	before_action :authenticate_user!
	before_action :set_grow
	before_action :set_week, except: [:new, :create]


	def edit
		
	end


	def new
		@week = Week.new
	end


	def create
		@week = Week.new(week_params)

    respond_to do |format|
      if @week.save
        format.html { redirect_to [:admin, @week.grow], notice: 'Week was successfully created.' }
        format.json { render :show, status: :created, location: @grow }
      else
        format.html { render :new }
        format.json { render json: @grow.errors, status: :unprocessable_entity }
      end
    end
	end


	def update
		respond_to do |format|
      if @week.update(week_params)
        format.html { redirect_to [:admin, @week.grow], notice: 'Week was successfully updated.' }
        format.json { render :show, status: :ok, location: @week.grow }
      else
        format.html { render :edit }
        format.json { render json: @week.errors, status: :unprocessable_entity }
      end
    end
	end
	

	def destroy
		@week.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, @grow], notice: 'Week was successfully destroyed.' }
      format.json { head :no_content }
    end
	end

private
	def set_grow
		@grow = Grow.find(params[:grow_id]) 
	end

	def set_week
		@week = Week.find(params[:id]) 
	end


	def week_params
		params.require(:week).permit(
      :id,
      :week_type,
      :week_number,
      :start_date,
      :end_date,
      :grow_id
    )
	end
end