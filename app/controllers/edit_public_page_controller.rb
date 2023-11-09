# frozen_string_literal: true

class EditPublicPageController < ApplicationController
  before_action :get_current_user
  before_action :redirect_if_logged_out
  
  def index; end

  def update
    if @current_user.update(user_params)
      redirect_to edit_public_page_path, notice: 'Public page was successfully updated.'
    else
      flash.now[:error] = @current_user.errors.full_messages.to_sentence
      redirect_to edit_public_page_path
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
