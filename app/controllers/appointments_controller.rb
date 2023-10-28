class AppointmentsController < ApplicationController
  def new
  end

  def index
    @username = params[:username]
    @user=User.find_by(fname:params[:username])
    if @user.nil?
      @user=User.all.limit(1)[0]
      redirect_to public_page_path(@user.fname)
    end
    @service_id = params[:service_id]
    @service=Service.find_by(id:params[:service_id])
    if not @service.nil?
      @appointment=Appointments.new
      #  slots_controller = SlotsController.new
      #  slots_controller.fetch_data
      #   @data =slots_controller.instance_variable_get(:@data)

      @slots_data_start_datetime  = [
    "2023-10-24T17:00:00.891Z",
    "2023-10-24T17:30:00.891Z",
    "2023-10-24T18:00:00.891Z",
    "2023-10-24T18:30:00.891Z",
    "2023-10-24T19:00:00.891Z",
    "2023-10-24T19:30:00.891Z",
    "2023-10-24T20:00:00.891Z",
    "2023-10-24T20:30:00.891Z",
    "2023-10-24T21:00:00.891Z",
    "2023-10-24T21:30:00.891Z"
  ]
      api_slots_data_start_datetime = [
    "2023-10-24T17:00:00.891Z",
    "2023-10-24T17:30:00.891Z",
    "2023-10-24T18:00:00.891Z",
    "2023-10-24T18:30:00.891Z",
    "2023-10-24T19:00:00.891Z",
    "2023-10-24T19:30:00.891Z",
    "2023-10-24T20:00:00.891Z",
    "2023-10-24T20:30:00.891Z",
    "2023-10-24T21:00:00.891Z",
    "2023-10-24T21:30:00.891Z"
  ]
  api_slots_data_end_datetime = [
  "2023-10-24T17:30:00.891Z",
  "2023-10-24T18:00:00.891Z",
  "2023-10-24T18:30:00.891Z",
  "2023-10-24T19:00:00.891Z",
  "2023-10-24T19:30:00.891Z",
  "2023-10-24T20:00:00.891Z",
  "2023-10-24T20:30:00.891Z",
  "2023-10-24T21:00:00.891Z",
  "2023-10-24T21:30:00.891Z",
  "2023-10-24T22:00:00.891Z"
]

dummy_slots_data_start_datetime = []
dummy_slots_data_end_datetime = []
@slots=[]
  for i in 0... api_slots_data_start_datetime.length
    # puts DateTime.parse(api_slots_data_start_datetime[i])+@service.duration.minutes
    # puts DateTime.parse(api_slots_data_end_datetime[i])
    # puts DateTime.parse(api_slots_data_start_datetime[i])+@service.duration.minutes<= DateTime.parse(api_slots_data_end_datetime[i])
    if  DateTime.parse(api_slots_data_start_datetime[i])+@service.duration.minutes <= DateTime.parse(api_slots_data_end_datetime[i])
    @slots[i]={'startTime':DateTime.parse(api_slots_data_start_datetime[i]),'endTime':DateTime.parse(api_slots_data_end_datetime[i])}
    dummy_slots_data_start_datetime.push(DateTime.parse(api_slots_data_start_datetime[i]))
    dummy_slots_data_end_datetime.push(DateTime.parse(api_slots_data_end_datetime[i]))
    end
  end
  @slots_data_start_datetime =dummy_slots_data_start_datetime
  @slots_data_end_datetime = dummy_slots_data_end_datetime
  else
    redirect_to public_page_path(@username)
  end
end

# def fetch_slot_times
#   puts @slots_data_start_time.inspect
#   puts @slots_data_end_time.inspect
#   date_selected = params[:start_date]
#     puts "hllo ",date_selected
#     # $slots_data_start_time=[
#     #   "2023-10-24T17:00:00.891Z",
#     #   "2023-10-24T17:30:00.891Z",
#     #   "2023-10-24T18:00:00.891Z",
#     #   "2023-10-24T18:30:00.891Z",
#     #   "2023-10-24T19:00:00.891Z",
#     #   "2023-10-24T19:30:00.891Z",
#     #   "2023-10-24T20:00:00.891Z",
#     #   "2023-10-24T20:30:00.891Z",
#     #   "2023-10-24T21:00:00.891Z",
#     #   "2023-10-24T21:30:00.891Z"
#     # ]
#     # $slots_data_end_time=[
#     #   "2023-10-24T17:30:00.891Z",
#     #   "2023-10-24T18:00:00.891Z",
#     #   "2023-10-24T18:30:00.891Z",
#     #   "2023-10-24T19:00:00.891Z",
#     #   "2023-10-24T19:30:00.891Z",
#     #   "2023-10-24T20:00:00.891Z",
#     #   "2023-10-24T20:30:00.891Z",
#     #   "2023-10-24T21:00:00.891Z",
#     #   "2023-10-24T21:30:00.891Z",
#     #   "2023-10-24T22:00:00.891Z"
#     # ]

# puts "1"
# $slots_data_start_time=start_times.map do |start_time_ele|
#   timstamp= DateTime.parse(start_time_ele)
#   current_date=DateTime.parse(date_selected)
#   DateTime.new(current_date.year, current_date.month, current_date.day,timstamp.hour,timstamp.min,timstamp.sec,timstamp.zone)
# end
# puts "2"
# $slots_data_end_time=end_times.map do |end_time_ele|
#   timstamp= DateTime.parse(end_time_ele)
#   current_date=DateTime.parse(date_selected)
#    DateTime.new(current_date.year, current_date.month, current_date.day,timstamp.hour,timstamp.min,timstamp.sec,timstamp.zone)
# end
# puts "3"
# puts "$slots_data_start_time",$slots_data_start_time.inspect
# # puts $slots_data_end_time.inspect
# @slots=[]
# for i in 0...$slots_data_start_time.length
#   @slots[i]={'startTime':$slots_data_start_time[i],'endTime':$slots_data_end_time[i]}
# end
# render json: {slots: @slots}

# end

def create_submit

  @username = params[:username]
    @user=User.find_by(fname:params[:username])
    # if @user.nil?
    #  flash[:notice]="Invalid Username"
    #  redirect_to public_page_path(@user.fname)
    # end
    @service_id = params[:service_id]
    @service=Service.find_by(id:params[:service_id])
  @appointment = Appointments.new(appointments_params)
      flash[:error] ||= ""
      @errors=[]
    if @appointment.fname.nil? || @appointment.fname.empty?

      @errors.push("first name")
    end
    if @appointment.fname.nil? || @appointment.lname.empty?
      @errors.push( "last name")
    end
    if @appointment.email.nil? || @appointment.email.empty?
      @errors.push( "email")
    end

    if not @errors.empty?
      flash[:error] = "Please enter your " + @errors.join(", ")
      # render appointments_page_index_path(@username ,@service_id)
      # render :index
      redirect_to appointments_page_index_path(@username ,@service_id)
      return
    end

    api_slots_data_start_datetime = [
      "2023-10-24T17:00:00.891Z",
      "2023-10-24T17:30:00.891Z",
      "2023-10-24T18:00:00.891Z",
      "2023-10-24T18:30:00.891Z",
      "2023-10-24T19:00:00.891Z",
      "2023-10-24T19:30:00.891Z",
      "2023-10-24T20:00:00.891Z",
      "2023-10-24T20:30:00.891Z",
      "2023-10-24T21:00:00.891Z",
      "2023-10-24T21:30:00.891Z"
    ]
    api_slots_data_end_datetime = [
    "2023-10-24T17:30:00.891Z",
    "2023-10-24T18:00:00.891Z",
    "2023-10-24T18:30:00.891Z",
    "2023-10-24T19:00:00.891Z",
    "2023-10-24T19:30:00.891Z",
    "2023-10-24T20:00:00.891Z",
    "2023-10-24T20:30:00.891Z",
    "2023-10-24T21:00:00.891Z",
    "2023-10-24T21:30:00.891Z",
    "2023-10-24T22:00:00.891Z"
  ]

  @slots_data_start_datetime = []
  @slots_data_end_datetime = []
  @slots=[]
    for i in 0... api_slots_data_start_datetime.length
      # puts DateTime.parse(api_slots_data_start_datetime[i])+@service.duration.minutes
      # puts DateTime.parse(api_slots_data_end_datetime[i])
      # puts DateTime.parse(api_slots_data_start_datetime[i])+@service.duration.minutes<= DateTime.parse(api_slots_data_end_datetime[i])
      if  DateTime.parse(api_slots_data_start_datetime[i])+@service.duration.minutes <= DateTime.parse(api_slots_data_end_datetime[i])
      @slots[i]={'startTime':DateTime.parse(api_slots_data_start_datetime[i]),'endTime':DateTime.parse(api_slots_data_end_datetime[i])}
      @slots_data_start_datetime.push(DateTime.parse(api_slots_data_start_datetime[i]))
      @slots_data_end_datetime.push(DateTime.parse(api_slots_data_end_datetime[i]))
      end
    end
  #   # if @service.nil?
  #   #   flash[:notice] = "Invalid Service"
  #   #   redirect_to public_page_path(@user.fname)
  #   # end
    filtered_slots = @slots.select do |slot|
      # puts slot[:startTime]
      # puts DateTime.parse(@appointment.startdatetime.to_s)
      # puts slot[:startTime] == DateTime.parse(@appointment.startdatetime.to_s)
      # puts "slot[:startTime].to_i",slot[:startTime].to_i
      # puts "@appointment.startdatetime",@appointment.startdatetime
      # puts slot[:startTime]== @appointment.startdatetime
      # puts DateTime.parse(slot[:startTime]) == @appointment.startdatetime
       DateTime.parse(slot[:startTime].to_s) == DateTime.parse(@appointment.startdatetime.to_s)
      # { |slot| slot[:startTime] == @appointment.startdatetime }
    end
    # start_time=DateTime.iso8601(@appointment.startdatetime)
    # start_date=Date.parse(@appointment.start_date)
    # start_time=Time.parse(@appointment.start_time)
    # puts start_date,start_time
    # Combine the date and time strings
    puts "filtered_slots",filtered_slots
    puts @appointment.startdatetime
    end_time=    @appointment.startdatetime+@service.duration*60

    # end_time=filtered_slots[:startTime].to_i+@service.duration*60
    puts end_time
    # return
# combined_datetime = "#{@appointment.start_date} #{@appointment.start_time}"

# Parse the combined datetime string into a DateTime object
# timestamp = DateTime.parse(combined_datetime)

    # @appointment.startdatetime = new DataTime(@appointment.
    # start_time=@appointment.startdatetime
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
