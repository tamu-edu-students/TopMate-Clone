# frozen_string_literal: true

class EditPublicPageController < ApplicationController
  before_action :get_current_user
  before_action :redirect_if_logged_out

  def update
    if @current_user.update(user_params)
      redirect_to dashboard_path, success: 'Public page was successfully updated.'
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def get_current_user
    @current_user ||= User.find_by(user_id: session[:user_id])
  end

  def redirect_if_logged_out
    redirect_to login_url if @current_user.nil?
  end

  def user_params
    params.require(:user).permit(:fname, :lname, :about, :username)
  end
end
