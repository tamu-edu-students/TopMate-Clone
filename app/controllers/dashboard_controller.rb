# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :get_current_user
  before_action :redirect_if_logged_out
  
  def main; end

  private

  def get_current_user
    @current_user ||= User.find_by(user_id: session[:user_id])
  end
  
  def redirect_if_logged_out
    redirect_to login_url if @current_user.nil?
  end
end
