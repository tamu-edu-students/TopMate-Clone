# frozen_string_literal: true

class ServicesController < ApplicationController
  def new
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      @service = Service.new
    end
  end

  def create
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      @service = @current_user.services.new(service_params)
      @service.user_id = @current_user.user_id
      if @service.save
        redirect_to root_path, notice: 'Service created successfully.'
      else
        render :new
      end
    end
  end

  def index
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      @services = @current_user.services
    end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price, :duration)
  end
end
