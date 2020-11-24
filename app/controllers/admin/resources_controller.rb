class Admin::ResourcesController < Admin::AdminController
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.all

    if params[:category_id] and !params[:category_id].empty?
      @resources = @resources.where(category_id: params[:category_id])
    end

    respond_to do |format|
      format.html
      format.json { render json: @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @resource }
    end
  end

  # GET /resources/new
  def new
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        @resource.choices = resource_params[:choices][0].split(', ')
        @resource.units = resource_params[:units][0].split(', ')
        @resource.save

        format.html { redirect_to admin_resources_url, notice: 'Resource was successfully created.' }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        @resource.choices = resource_params[:choices][0].split(', ')
        @resource.units = resource_params[:units][0].split(', ')
        @resource.save

        format.html { redirect_to admin_resources_url, notice: 'Resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to admin_resources_url, notice: 'Resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(
        :name, 
        :shortname, 
        :description, 
        :category_id, 
        choices: [], 
        units: [])
    end
end
