# frozen_string_literal: true

class AppointmentsController < ApplicationController
  include AppointmentsHelper
  def new; end

  def index
    @username = params[:username]
    @user = User.find_by(username: params[:username])
    if @user.nil?
      @user = User.all.limit(1)[0]
      redirect_to public_page_path(@user.username)
    end
    @service_id = params[:service_id]
    @service = Service.find_by(id: params[:service_id])
    if !@service.nil?
      @appointment = Appointments.new
      start_date = Date.today
      next_seven_days = []

      # Iterate through the next seven days and add them to the array
      7.times do |day_offset|
        next_seven_days << start_date + day_offset
      end
      @slots_data_start_date = next_seven_days
      @slots_data_start_time = []
      # api_data= get_next_seven_day_time_slots(@user, Date.today)
      # dummy_slots_data_start_datetime = []
      # dummy_slots_data_end_datetime = []
      # @slots=[]
      #   for i in 0... api_data.length
      #     if  DateTime.parse(api_data[i]["start_date_time"].to_s)+@service.duration.minutes <= DateTime.parse(api_data[i]["end_date_time"].to_s)
      #     @slots[i]={'startTime':DateTime.parse(api_data[i]["start_date_time"].to_s),'endTime':DateTime.parse(api_data[i]["end_date_time"].to_s)}
      #     dummy_slots_data_start_datetime.push(DateTime.parse(api_data[i]["start_date_time"].to_s))
      #     dummy_slots_data_end_datetime.push(DateTime.parse(api_data[i]["end_date_time"].to_s))
      #     end
      #   end
      #   @slots_data_start_datetime =dummy_slots_data_start_datetime
      #   @slots_data_end_datetime = dummy_slots_data_end_datetime
    else
      redirect_to public_page_path(@username)
    end
  end

  def fetch_slot_times_api
    @current_start_date = DateTime.parse(params[:start_date])
    @username = params[:username]
    @username = params[:username]
    @user = User.find_by(username: params[:username])
    api_data = user_availability_for_day(@user, @current_start_date)
    dummy_slots_data_start_datetime = []
    dummy_slots_data_end_datetime = []
    @slots = []
    if api_data.present?
      (0...api_data.length).each do |i|
        # if  DateTime.parse(api_data[i]["start_date_time"].to_s)+@service.duration.minutes <= DateTime.parse(api_data[i]["end_date_time"].to_s)
        @slots[i] = { 'startTime': api_data[i]['start_time'], 'endTime': api_data[i]['end_time'] }
        dummy_slots_data_start_datetime.push(api_data[i]['start_time'])
        dummy_slots_data_end_datetime.push(api_data[i]['end_time'])
        # end
      end
    end
    @slots_data_start_datetime = dummy_slots_data_start_datetime
    @slots_data_end_datetime = dummy_slots_data_end_datetime
    @slots_data_start_time = @slots_data_start_datetime
    resposne = { slots: @slots }
    render json: resposne
  end

  def edit
    @appointment = Appointment.find_by(id: params[:id])
    @user = User.find_by(user_id: @appointment.user_id)
    @service = Service.find_by(id: @appointment.service_id)
    api_data = get_next_seven_day_time_slots(@user, Date.today)
    dummy_slots_data_start_datetime = []
    dummy_slots_data_end_datetime = []
    @slots = []
    (0...api_data.length).each do |i|
      unless DateTime.parse(api_data[i]['start_date_time'].to_s) + @service.duration.minutes <= DateTime.parse(api_data[i]['end_date_time'].to_s)
        next
      end

      @slots[i] =
        { 'startTime': DateTime.parse(api_data[i]['start_date_time'].to_s),
          'endTime': DateTime.parse(api_data[i]['end_date_time'].to_s) }
      dummy_slots_data_start_datetime.push(DateTime.parse(api_data[i]['start_date_time'].to_s))
      dummy_slots_data_end_datetime.push(DateTime.parse(api_data[i]['end_date_time'].to_s))
    end
    @slots_data_start_datetime = dummy_slots_data_start_datetime
    @slots_data_end_datetime = dummy_slots_data_end_datetime
    if @appointment
      render :edit
    else
      redirect_to public_page_path(@user.username), alert: 'Invalid token'
    end
  end

  def update
    @appointment = Appointment.find_by(id: params[:id])
    @user = User.find_by(user_id: @appointment.user_id)

    get_next_seven_day_time_slots(@user, Date.today)

    @service = Service.find_by(id: @appointment.service_id)
    @appointment.enddatetime = @appointment.startdatetime + @service.duration.minutes
    if @appointment.update(update_params)
      redirect_to public_page_path(@user.username), success: 'Appointment updated successfully!'
    else
      render :edit
    end
  end

  def create_submit
    @username = params[:username]
    @user = User.find_by(username: params[:username])

    @service_id = params[:service_id]
    @service = Service.find_by(id: params[:service_id])
    @appointment = Appointments.new(appointments_params)
    flash[:error] ||= ''
    @errors = []
    @errors.push('first name') if @appointment.fname.nil? || @appointment.fname.empty?
    @errors.push('last name') if @appointment.lname.nil? || @appointment.lname.empty?
    @errors.push('email') if @appointment.email.nil? || @appointment.email.empty?
    unless @errors.empty?
      flash[:error] = "Please enter your #{@errors.join(', ')}"
      redirect_to appointments_page_index_path(@username, @service_id)
      return
    end

    # api_data= get_next_seven_day_time_slots(@user, Date.today)
    # dummy_slots_data_start_datetime = []
    # dummy_slots_data_end_datetime = []
    # @slots=[]
    #   for i in 0... api_data.length
    #     if  DateTime.parse(api_data[i]["start_date_time"].to_s)+@service.duration.minutes <= DateTime.parse(api_data[i]["end_date_time"].to_s)
    #     @slots[i]={'startTime':DateTime.parse(api_data[i]["start_date_time"].to_s),'endTime':DateTime.parse(api_data[i]["end_date_time"].to_s)}
    #     dummy_slots_data_start_datetime.push(DateTime.parse(api_data[i]["start_date_time"].to_s))
    #     dummy_slots_data_end_datetime.push(DateTime.parse(api_data[i]["end_date_time"].to_s))
    #     end
    #   end
    #   @slots_data_start_datetime =dummy_slots_data_start_datetime
    #   @slots_data_end_datetime = dummy_slots_data_end_datetime
    @current_start_date = DateTime.parse(params[:appointments][:start_date])
    api_data = user_availability_for_day(@user, @current_start_date)
    dummy_slots_data_start_datetime = []
    dummy_slots_data_end_datetime = []
    @slots = []
    if api_data.present?
      (0...api_data.length).each do |i|
        # Parse the date and time strings
        date = Date.parse(@current_start_date.to_s)
        start_time = Time.parse(api_data[i]['start_time'])
        end_time = Time.parse(api_data[i]['end_time'])

        # Create a DateTime object
        combined_start_date_time = DateTime.new(date.year, date.month, date.day, start_time.hour, start_time.min, 0)
        combined_end_date_time = DateTime.new(date.year, date.month, date.day, end_time.hour, end_time.min, 0)

        # if  DateTime.parse(api_data[i]["start_date_time"].to_s)+@service.duration.minutes <= DateTime.parse(api_data[i]["end_date_time"].to_s)
        # @slots[i]={'startTime':api_data[i]["start_time"],'endTime':api_data[i]["end_time"]}
        @slots[i] = { 'startTime': combined_start_date_time, 'endTime': combined_end_date_time }
        dummy_slots_data_start_datetime.push(combined_start_date_time)
        dummy_slots_data_end_datetime.push(combined_end_date_time)
        # end
      end
    end
    @slots_data_start_datetime = dummy_slots_data_start_datetime
    @slots_data_end_datetime = dummy_slots_data_end_datetime
    selected_date = Date.parse(@current_start_date.to_s)
    start_time = params[:appointments][:start_time] || api_data[0]['start_time']
    selected_start_time = Time.parse(start_time)
    # || @slots[0][:start_time]

    # Create a DateTime object
    combined_appt_date_time = DateTime.new(selected_date.year, selected_date.month, selected_date.day,
                                           selected_start_time.hour, selected_start_time.min, 0)
    @slots.select do |slot|
      DateTime.parse(slot[:startTime].to_s) == combined_appt_date_time
      #  DateTime.parse(slot[:startTime].to_s) == DateTime.parse(@appointment.startdatetime.to_s)
    end
    @appointment.startdatetime = combined_appt_date_time
    end_time = @appointment.startdatetime + @service.duration.minutes
    @appointment.enddatetime = end_time
    @appointment.user_id = @user.id
    @appointment.amount_paid = @service.price.to_f
    @appointment.service_id = @service.id
    @appointment.status = Appointments.status_types['booked']

    @save = @appointment.save!
    if @save
      AppointmentMailer.edit_link_email(@appointment).deliver_now
      redirect_to public_page_path(@username), success: 'Appoinment Created successfully'
    else
      redirect_to appointments_page_index_path(@username, @service_id), notice: 'Appoinment Creation Failed'
    end
  end

  def destroy
    @appointment = Appointment.find_by(id: params[:id])
    @appointment.update(status: Appointments.status_types['cancelled'])
    @appointment.save
    redirect_to public_page_path(@appointment.user.username), success: 'Appointment cancelled successfully!'
  end

  private

  def appointments_params
    params.require(:appointments).permit(:fname, :lname, :email, :startdatetime)
  end

  def update_params
    params.require(:appointment).permit(:fname, :lname, :startdatetime)
  end
end
