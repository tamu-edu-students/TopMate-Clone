class SessionsController < ApplicationController
    def new
    end
  
    def create
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_url, notice: "Logged in successfully!"
      else
        flash.now[:error] = "Invalid email or password"
        redirect_to sessions_new_path
      end
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to root_url, notice: "Logged out successfully!"
    end
  end