class Admin::AlertsController < Admin::AdminController
  before_action :set_alert, only: [:show, :edit, :update, :destroy, :test, :clear, :trigger]

  # GET /alerts
  # GET /alerts.json
  def index
    @alerts = Alert.all.order(:created_at)
  end

  # GET /alerts/1
  # GET /alerts/1.json
  def show
  end

  # GET /alerts/new
  def new
    @alert = Alert.new
  end

  # GET /alerts/1/edit
  def edit
  end

  # POST /alerts
  # POST /alerts.json
  def create
    @alert = Alert.new(alert_params)

    respond_to do |format|
      if @alert.save
        format.html { redirect_to admin_alerts_url, notice: 'Alert was successfully created.' }
        format.json { render :show, status: :created, location: @alert }
      else
        format.html { render :new }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alerts/1
  # PATCH/PUT /alerts/1.json
  def update
    respond_to do |format|
      if @alert.update(alert_params)
        format.html { redirect_to admin_alerts_url, notice: 'Alert was successfully updated.' }
        format.json { render :show, status: :ok, location: @alert }
      else
        format.html { render :edit }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alerts/1
  # DELETE /alerts/1.json
  def destroy
    @alert.destroy
    respond_to do |format|
      format.html { redirect_to admin_alerts_url, notice: 'Alert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def test
    @alert.test_alert

    redirect_to request.referrer, notice: 'Alert was successfully tested.'
  end

  def trigger
    @alert.trigger

    redirect_to request.referrer, notice: 'Alert was successfully triggered.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alert_params
      params.require(:alert).permit(
        :alert_type, 
        :data_type_id, 
        :resource_id, 
        :operator, 
        :value, 
        :message,
        :enabled,
        :push_enabled, 
        user_ids: [],
        push_user_ids: [])
    end
end
