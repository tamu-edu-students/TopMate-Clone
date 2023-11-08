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
  end

  def edit_intial
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      @service = Service.find_by(id: params[:token])

      if @service.nil?
        render plain: 'Service does not exist.'
      else
        render :edit_service
      end
    end
  end

  def edit
    # puts 'inside edit post route'

    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      @service = Service.find_by(id: params[:token])

      # puts 'searched for the service'

      if @service.nil?
        puts 'service not available'
        flash[:error] = 'Service not found'
        render plain: 'Service does not exist.'

        # redirect_back(fallback_location: root_path)
      elsif @service.update(service_params)
        # Update service attributes one by one
        # puts 'updating the services'

        redirect_to servicesindex_url
      # puts 'updated the service succesfully'
      else
        flash[:error] = 'Failed to update service'
        redirect_back(fallback_location: root_path)
      end
    end

    # puts 'completed redirecting'
  end

  def togglepublish
    if User.find_by(user_id: session[:user_id]).nil?
      redirect_to login_url
    else
      @service = Service.find_by(id: params[:id], user_id: session[:user_id])
      if @service.nil?
        puts 'service not available'
        flash[:error] = 'Service not found'
        render plain: 'Service does not exist.'
      else
        # Toggle publish status
        if @service.update(is_published: !@service.is_published)
          redirect_to servicesindex_url
        else
          flash[:error] = 'Failed to update service'
          redirect_back(fallback_location: root_path)
        end
      end
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
    @current_user ||= User.find_by(user_id: session[:user_id])
    if @current_user.nil?
      redirect_to login_url
    else
      @services = @current_user.services.where(hidden: false)
    end
  end

  def hide
    @service = Service.find(params[:id])
    @service.update(hidden: true)  # Add a 'hidden' boolean column to the 'services' table

    redirect_to servicesindex_path, notice: 'Service deleted successfully.'
  end

  private

  def service_params
    params.require(:service).permit(:name, :short_description, :description, :price, :duration)
  end
end
