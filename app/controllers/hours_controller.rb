# frozen_string_literal: true

class HoursController < ApplicationController
  before_action :get_current_user
  before_action :redirect_if_logged_out

  # GET /hours or /hours.json
  def index
    hours = Hour.where(user_id: @current_user.user_id)
    sorted = Array.new(7) { [] }
    hours.each do |h|
      sorted[h.day] << h
    end
    @days = sorted
  end

  # GET /hours/new
  def new
    @hour = Hour.new
    dayObject = Struct.new(:id, :day)
    @days = Date::DAYNAMES.map.with_index { |day, index| dayObject.new(index, day) }
  end

  # POST /hours or /hours.json
  def create
    dayObject = Struct.new(:id, :day)
    @days = Date::DAYNAMES.map.with_index { |day, index| dayObject.new(index, day) }
    @hour = @current_user.hours.new(hour_params)
    if @hour.save
      redirect_to hours_url, success: 'Time slot successfully added!'
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hours/1 or /hours/1.json
  def destroy
    if @current_user.hours.find(params[:id]).destroy
      redirect_to hours_url, success: 'Time slot successfully deleted!'
    else
      redirect_to hours_url, error: 'Time slot failed to delete.'
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def hour_params
    params.require(:hour).permit(:day, :start_time, :end_time)
  end

  def get_current_user
    @current_user ||= User.find_by(user_id: session[:user_id])
  end

  def redirect_if_logged_out
    redirect_to login_url if @current_user.nil?
  end
end
