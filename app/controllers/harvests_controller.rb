class HarvestsController < ApplicationController

  before_action :set_grow, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_harvest, only: [:show, :edit, :update, :destroy]


  # GET /harvests
  # GET /harvests.json
  def index
    @harvests = Harvest.all
  end

  # GET /harvests/1
  # GET /harvests/1.json
  def show
  end

  # GET /harvests/new
  def new
    @harvest = Harvest.new
  end

  # GET /harvests/1/edit
  def edit
  end

  # POST /harvests
  # POST /harvests.json
  def create
    @harvest = Harvest.new(harvest_params)

    respond_to do |format|
      if @harvest.save
        format.html { redirect_to @harvest, notice: 'Harvest was successfully created.' }
        format.json { render :show, status: :created, location: @harvest }
      else
        format.html { render :new }
        format.json { render json: @harvest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /harvests/1
  # PATCH/PUT /harvests/1.json
  def update
    respond_to do |format|
      if @harvest.update(harvest_params)
        format.html { redirect_to @harvest, notice: 'Harvest was successfully updated.' }
        format.json { render :show, status: :ok, location: @harvest }
      else
        format.html { render :edit }
        format.json { render json: @harvest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /harvests/1
  # DELETE /harvests/1.json
  def destroy
    @harvest.destroy
    respond_to do |format|
      format.html { redirect_to harvests_url, notice: 'Harvest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_grow
      @grow = Grow.find(params[:grow_id])

      add_breadcrumb "Grow ##{@grow.id}", @grow
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_harvest
      @harvest = Harvest.find(params[:id])

      add_breadcrumb "Harvest"
    end

    # Only allow a list of trusted parameters through.
    def harvest_params
      params.require(:harvest).permit(:grow, :harvested_trim_weight, :harvested_waste_weight, :harvested_bud_weight, :dry_trim_weight, :dry_bud_weight)
    end
end
