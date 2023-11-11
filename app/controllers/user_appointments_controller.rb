# frozen_string_literal: true

class UserAppointmentsController < ApplicationController
  def show
    @current_user ||= User.find_by(user_id: session[:user_id])
    @username = params[:username]
    @user = User.find_by(username: @username)
    if @user.nil? 
      render 'user_appointments/user_not_found'
    elsif @current_user.nil? || (@current_user.user_id!=@user.user_id)
      redirect_to login_url
    else
      @services = Service.where(hidden: false, is_published: true)
      @appointments = Appointment.where(user_id: User.find_by(username: @username).id)
      # puts "appointments are here"
      # puts @services.name
      # puts @appointments.fname
      render 'user_appointments/index'
     
    end
  end
end
