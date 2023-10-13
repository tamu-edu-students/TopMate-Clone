# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :is_logged_in
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(user_id: session[:user_id])
  end

  def require_login
    redirect_to login_url, alert: 'You must be logged in to access this page.' if current_user.nil?
  end

  def is_logged_in
    redirect_to dashboard_url if current_user
  end
end
