# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :get_current_user
  before_action :redirect_if_logged_in, only: %i[new]

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.user_id
      redirect_to dashboard_path, notice: 'Logged in successfully!'
    else
      flash[:error] = 'Invalid email or password'
      redirect_to sessions_new_path
    end
  end

  def destroy
    session[:user_id] = nil
    if @current_user.nil?
      redirect_to root_url
    else
      @current_user = nil
      redirect_to root_url, notice: 'Logged out successfully!'
    end
  end

  private

  def get_current_user
    @current_user ||= User.find_by(user_id: session[:user_id])
  end

  def redirect_if_logged_in
    redirect_to dashboard_url unless @current_user.nil?
  end
end
