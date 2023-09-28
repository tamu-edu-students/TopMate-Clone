class ApplicationController < ActionController::Base
    helper_method :current_user
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    def require_login
      redirect_to login_url, alert: "You must be logged in to access this page." if current_user.nil?
    end
  end