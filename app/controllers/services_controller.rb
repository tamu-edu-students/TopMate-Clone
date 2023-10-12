class ServicesController < ApplicationController
    def new
      @current_user ||= User.find_by(user_id: session[:user_id])
      redirect_to login_url if @current_user.nil?
      @service = Service.new
    end
  
    def create
      @current_user ||= User.find_by(user_id: session[:user_id])
      redirect_to login_url if @current_user.nil?
      @service = @current_user.services.new(service_params)
      @service.user_id = @current_user.user_id
      if @service.save
        redirect_to root_path, notice: "Service created successfully."
      else
        render :new
      end
    end

    def index
      @current_user ||= User.find_by(user_id: session[:user_id])
      redirect_to login_url if @current_user.nil?
      @services = @current_user.services
    end

    private
  
    def service_params
      params.require(:service).permit(:name, :description, :price, :duration)
    end
end
 