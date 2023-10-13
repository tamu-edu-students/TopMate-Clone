class HoursController < ApplicationController
  before_action :set_hour, only: %i[ show edit update destroy ]

  # GET /hours or /hours.json
  def index
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      hours = Hour.where(user_id: @current_user.user_id)
      sorted = Array.new(7) { [] }
      hours.each do |h|
        sorted[h.day] << h
      end
      @days = sorted
    end
  end

  # GET /hours/new
  def new
    @hour = Hour.new
  end

  # POST /hours or /hours.json
  def create
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      @hour = Hour.new(hour_params)
      @hour.user_id = @current_user.user_id
      respond_to do |format|
        if @hour.save
          format.html { redirect_to hours_url(@hour), notice: "Hour was successfully created." }
          format.json { render :show, status: :created, location: @hour }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @hour.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /hours/1 or /hours/1.json
  def destroy
    @hour.destroy

    respond_to do |format|
      format.html { redirect_to hours_url, notice: "Hour was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hour
      @hour = Hour.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hour_params
      params.require(:hour).permit(:day, :start_time, :end_time)
    end
end
