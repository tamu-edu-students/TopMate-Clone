class AppointmentsController < ApplicationController
include ServicesHelper
  def new
  end

  def index
    @username = params[:username]
    @user=User.find_by(username:params[:username])
    if @user.nil?
      @user=User.all.limit(1)[0]
      redirect_to public_page_path(@user.username)
    end
    @service_id = params[:service_id]
    @service=Service.find_by(id:params[:service_id])
    if not @service.nil?
      @appointment=Appointments.new

api_data= get_next_seven_day_time_slots(@user, Date.today)
dummy_slots_data_start_datetime = []
dummy_slots_data_end_datetime = []
@slots=[]
  for i in 0... api_data.length
    if  DateTime.parse(api_data[i]["start_date_time"].to_s)+@service.duration.minutes <= DateTime.parse(api_data[i]["end_date_time"].to_s)
    @slots[i]={'startTime':DateTime.parse(api_data[i]["start_date_time"].to_s),'endTime':DateTime.parse(api_data[i]["end_date_time"].to_s)}
    dummy_slots_data_start_datetime.push(DateTime.parse(api_data[i]["start_date_time"].to_s))
    dummy_slots_data_end_datetime.push(DateTime.parse(api_data[i]["end_date_time"].to_s))
    end
  end
  @slots_data_start_datetime =dummy_slots_data_start_datetime
  @slots_data_end_datetime = dummy_slots_data_end_datetime
  else
    redirect_to public_page_path(@username)
  end
end

def create_submit

  @username = params[:username]
    @user=User.find_by(username:params[:username])

    @service_id = params[:service_id]
    @service=Service.find_by(id:params[:service_id])
  @appointment = Appointments.new(appointments_params)
      flash[:error] ||= ""
      @errors=[]
    if @appointment.fname.nil? || @appointment.fname.empty?

      @errors.push("first name")
    end
    if @appointment.lname.nil? || @appointment.lname.empty?
      @errors.push( "last name")
    end
    if @appointment.email.nil? || @appointment.email.empty?
      @errors.push( "email")
    end

    if not @errors.empty?
      flash[:error] = "Please enter your " + @errors.join(", ")
      redirect_to appointments_page_index_path(@username ,@service_id)
      return
    end

    api_data= get_next_seven_day_time_slots(@user, Date.today)
    dummy_slots_data_start_datetime = []
    dummy_slots_data_end_datetime = []
    @slots=[]
      for i in 0... api_data.length
        if  DateTime.parse(api_data[i]["start_date_time"].to_s)+@service.duration.minutes <= DateTime.parse(api_data[i]["end_date_time"].to_s)
        @slots[i]={'startTime':DateTime.parse(api_data[i]["start_date_time"].to_s),'endTime':DateTime.parse(api_data[i]["end_date_time"].to_s)}
        dummy_slots_data_start_datetime.push(DateTime.parse(api_data[i]["start_date_time"].to_s))
        dummy_slots_data_end_datetime.push(DateTime.parse(api_data[i]["end_date_time"].to_s))
        end
      end
      @slots_data_start_datetime =dummy_slots_data_start_datetime
      @slots_data_end_datetime = dummy_slots_data_end_datetime
    filtered_slots = @slots.select do |slot|
       DateTime.parse(slot[:startTime].to_s) == DateTime.parse(@appointment.startdatetime.to_s)
    end
    end_time=    @appointment.startdatetime+@service.duration.minutes
    @appointment.enddatetime=end_time
    @appointment.amount_paid=@service.price.to_f
    @appointment.service_id=@service.id
    @appointment.status=Appointments.status_types["booked"]

    @save=@appointment.save!
    if @save
      redirect_to public_page_path(@username), success: 'Appoinment Created successfully'
    else
      redirect_to appointments_page_index_path(@username ,@service_id), notice: 'Appoinment Creation Failed'
  end
end
  private
  def appointments_params
    params.require(:appointments).permit(:fname, :lname, :email, :startdatetime)
  end
end
