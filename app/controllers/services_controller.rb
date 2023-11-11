# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :get_current_user
  before_action :redirect_if_logged_out, except: %i[show]

  def new
    @service = Service.new
  end

  def create
    @service = @current_user.services.new(service_params)
    @service.user_id = @current_user.user_id
    respond_to do |format|
      if @service.save
        format.html { redirect_to servicesindex_path, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit_page
    @service = @current_user.services.find_by(id: params[:token])
    if @service.nil?
      render plain: 'Service does not exist.'
    else
      render :edit_service
    end
  end

  def submit_edit
    @service = @current_user.services.find_by(id: params[:token])
    if @service.nil?
      flash[:error] = 'Service not found'
      render plain: 'Service does not exist.'
    elsif @service.update(service_params)
      redirect_to servicesindex_url
    else
      flash[:error] = 'Failed to update service'
      redirect_back(fallback_location: root_path)
    end
  end

  def togglepublish
    @service = @current_user.services.find_by(id: params[:id], user_id: session[:user_id])
    if @service.nil?
      flash[:error] = 'Service not found'
      render plain: 'Service does not exist.'
    elsif @service.update(is_published: !@service.is_published)
      # Toggle publish status
      redirect_to servicesindex_url
    else
      flash[:error] = 'Failed to update service'
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @username = params[:username]
    service = Service.find_by(id: params[:id])
    if service.nil? || !service.is_published
      @service = nil
    else
      @service_owner ||= User.find_by(user_id: service.user_id)
      @service = service
    end
  end

  def index
    @services = @current_user.services.where(hidden: false)
  end

  def hide
    @service = @current_user.services.find_by(id: params[:id])
    @service.update(hidden: true) # Add a 'hidden' boolean column to the 'services' table
    redirect_to servicesindex_path, notice: 'Service deleted successfully.'
  end

  private

  def service_params
    params.require(:service).permit(:name, :short_description, :description, :price, :duration)
  end

  def get_current_user
    @get_current_user ||= User.find_by(user_id: session[:user_id])
  end

  def redirect_if_logged_out
    redirect_to login_url if @current_user.nil?
  end
end
