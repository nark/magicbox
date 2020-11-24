class SubjectsController < ApplicationController
  before_action :authenticate_user!
  
  before_action :set_grow, only: [:index, :new, :show, :edit, :update, :destroy]
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    add_breadcrumb "Subjects"

    @subjects = @grow.subjects.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to admin_grow_subject_path(@subject.grow, @subject), notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to admin_grow_subject_path(@subject.grow, @subject), notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to admin_subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_grow
      @grow = Grow.find(params[:grow_id])

      add_breadcrumb "Grow ##{@grow.id}", [:admin, @grow]
    end


    def set_subject
      @subject = Subject.find(params[:id])

      add_breadcrumb @subject.name, [:admin, @grow, @subject]
    end

    def subject_params
      params.require(:subject).permit(:name, :room_id, :grow_id)
    end
end
