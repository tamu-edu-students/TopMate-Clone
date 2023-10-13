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
          redirect_to root_path, notice: "Service created successfully."
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


    def edit_intial
      @service = Service.find_by(id: params[:token])
      
      if @service.nil?
        render plain: "Service with ID #{params[:token]} does not exist."
      else 
        render :edit_service
      end
    end
      
      
    def edit

      puts "inside edit post route"

      @service = Service.find_by(id: params[:token])

      puts "searched for the service"

      if @service.nil?
        puts "service not available" 
        flash[:error] = "Service not found"
        render plain: "Service with ID #{params[:token]} does not exist."

        # redirect_back(fallback_location: root_path)
      else
        # Update service attributes one by one
        puts "updating the services"
        
        # @service.name = params[:name] if params[:name].present?
        # @service.description = params[:description] if params[:description].present?
        # @service.price = params[:price] if params[:price].present?
        # @service.duration = params[:duration] if params[:duration].present?


    
        if @service.update(service_params)
          puts "updated the service succesfully"
          redirect_to servicesindex_url
        else
          flash[:error] = "Failed to update service"
          redirect_back(fallback_location: root_path)
        end
      end
      puts "completed redirecting"
    end


    private
  
    def service_params
      params.require(:service).permit(:name, :description, :price, :duration)
    end

    
end


 