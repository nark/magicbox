class GrowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_grow, only: [:show, :print_qr]

  # GET /grows
  # GET /grows.json
  def index
    @grows = Grow.all

    add_breadcrumb "Grows"
  end

  # GET /grows/1
  # GET /grows/1.json
  def show
    @todos_json = current_user.todos.to_json(methods: [:text, :url, :color, :start_date, :end_date])
    @weeks_json = @grow.weeks.joins(:grow).where.not('grows.grow_status': [:done, :aborted]).to_json(methods: [:text, :url, :color])
    @observations_json = @grow.observations.all.to_json(methods: [:start_date, :end_date, :text, :url])
    @issues_json = Issue.where(issue_status: :open).to_json(methods: [:start_date, :end_date, :text, :url, :color])

    respond_to do |format|
      format.html
      format.json { render json: @grow.to_json(include: :subjects) }
    end
  end


  def print_qr
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grow
      @grow = Grow.find(params[:id])

      add_breadcrumb "Grow ##{@grow.id}"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grow_params
      params.require(:grow).permit(
        :grow_status, 
        :description, 
        :start_date, 
        :seedling_weeks,
        :vegging_weeks, 
        :flowering_weeks,
        :flushing_weeks,
        :drying_weeks,
        :curing_weeks,
        :substrate, 
        :flowering,
        :number_of_subjects)
    end
end
