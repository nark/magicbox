class Api::V1::SubjectsController < ApiController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  resource_description do
    short 'Subjects'
    description "Subjects are blavlavla"
    meta "Subjects" => ["id", "name", "created_at", "updated_at"]
    formats ['json']
    deprecated false
  end

  def_param_group :subject do
    param :subject, Hash do
      param :name, String, desc: "The name of the subject", required: true
      param :created_at, DateTime, desc: "The creation date", required: false
      param :created_at, DateTime, desc: "The update date", required: false
    end
  end


  # GET /subjects
  api :GET, '/v1/subjects', "Get a list of subjects"
  param :limit, :number, desc: "Limit number of items (default: 100, max: 1000)"
  param :offset, :number, desc: "Offset of items"
  param :sort_direction, ["asc", "desc"], desc: "The sort direction key"
  param :sort_column, ["id", "name", "created_at", "updated_at"], desc: "The sort column name"
  def index
    @items = Subject.all

    if params.has_key? :sort_direction and params.has_key? :sort_column
      @items = @items.order("#{params[:sort_column]} #{params[:sort_direction]}")
    else
      @items = @items.order(created_at: :asc)
    end

    if params.has_key? :limit
      @items = @items.limit(params[:limit])
    else
      @items = @items.limit(100)
    end

    if params.has_key? :offset
      @items = @items.offset(params[:offset])
    end

    render json: @items, methods: [:strain_name], include: [
      :grow, 
      :room, 
      scenarios: {}
    ]
  end


  # GET /subjects/1
  api :GET, '/v1/subjects/:id', "Get a subject item"
  def show
    render json: @subject, methods: [:strain_name], include: [
      :grow, 
      :room, 
      scenarios: {}
    ]
  end


  # POST /subjects
  api :POST, '/v1/subjects', "Create a new subject"
  param_group :subject
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  api :PATCH, '/v1/subjects/:id', "Update a subject"
  param_group :subject
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  api :DELETE, '/v1/subjects/:id', "Delete a subject"
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name)
    end
end
