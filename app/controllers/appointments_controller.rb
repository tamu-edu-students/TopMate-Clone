class AppointmentsController < ApplicationController
  $slots_data_start_time=[]
  $slots_data_end_time=[]


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
      @slots_data_start_date = [
        "2023-10-24",
        "2023-10-26",
        "2023-10-27",
        "2023-10-28",
        "2023-10-29",
        "2023-10-30",
      ]

    # session[:slots] = @slots
    $slots_data_start_time=[]
    $slots_data_end_time=[]
  else
    redirect_to public_page_path(@username)
  end
end

def fetch_slot_times
  puts @slots_data_start_time.inspect
  puts @slots_data_end_time.inspect
  date_selected = params[:start_date]
    puts "hllo ",date_selected
    # $slots_data_start_time=[
    #   "2023-10-24T17:00:00.891Z",
    #   "2023-10-24T17:30:00.891Z",
    #   "2023-10-24T18:00:00.891Z",
    #   "2023-10-24T18:30:00.891Z",
    #   "2023-10-24T19:00:00.891Z",
    #   "2023-10-24T19:30:00.891Z",
    #   "2023-10-24T20:00:00.891Z",
    #   "2023-10-24T20:30:00.891Z",
    #   "2023-10-24T21:00:00.891Z",
    #   "2023-10-24T21:30:00.891Z"
    # ]
    # $slots_data_end_time=[
    #   "2023-10-24T17:30:00.891Z",
    #   "2023-10-24T18:00:00.891Z",
    #   "2023-10-24T18:30:00.891Z",
    #   "2023-10-24T19:00:00.891Z",
    #   "2023-10-24T19:30:00.891Z",
    #   "2023-10-24T20:00:00.891Z",
    #   "2023-10-24T20:30:00.891Z",
    #   "2023-10-24T21:00:00.891Z",
    #   "2023-10-24T21:30:00.891Z",
    #   "2023-10-24T22:00:00.891Z"
    # ]
    start_times = [
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
end_times = [
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
puts "1"
$slots_data_start_time=start_times.map do |start_time_ele|
  timstamp= DateTime.parse(start_time_ele)
  current_date=DateTime.parse(date_selected)
  DateTime.new(current_date.year, current_date.month, current_date.day,timstamp.hour,timstamp.min,timstamp.sec,timstamp.zone)
end
puts "2"
$slots_data_end_time=end_times.map do |end_time_ele|
  timstamp= DateTime.parse(end_time_ele)
  current_date=DateTime.parse(date_selected)
   DateTime.new(current_date.year, current_date.month, current_date.day,timstamp.hour,timstamp.min,timstamp.sec,timstamp.zone)
end
puts "3"
puts "$slots_data_start_time",$slots_data_start_time.inspect
# puts $slots_data_end_time.inspect
@slots=[]
for i in 0...$slots_data_start_time.length
  @slots[i]={'startTime':$slots_data_start_time[i],'endTime':$slots_data_end_time[i]}
end
render json: {slots: @slots}

end

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

  #   @slots_data_start_time = [
  #     "2023-10-24T17:00:00.891Z",
  #     "2023-10-24T17:30:00.891Z",
  #     "2023-10-24T18:00:00.891Z",
  #     "2023-10-24T18:30:00.891Z",
  #     "2023-10-24T19:00:00.891Z",
  #     "2023-10-24T19:30:00.891Z",
  #     "2023-10-24T20:00:00.891Z",
  #     "2023-10-24T20:30:00.891Z",
  #     "2023-10-24T21:00:00.891Z",
  #     "2023-10-24T21:30:00.891Z"
  #   ]
  # @slots_data_end_time = [
  #   "2023-10-24T17:30:00.891Z",
  #   "2023-10-24T18:00:00.891Z",
  #   "2023-10-24T18:30:00.891Z",
  #   "2023-10-24T19:00:00.891Z",
  #   "2023-10-24T19:30:00.891Z",
  #   "2023-10-24T20:00:00.891Z",
  #   "2023-10-24T20:30:00.891Z",
  #   "2023-10-24T21:00:00.891Z",
  #   "2023-10-24T21:30:00.891Z",
  #   "2023-10-24T22:00:00.891Z"
  # ]
  # @slots=[]
  # for i in 0...@slots_data_start_time.length
  #   @slots[i]={'startTime':@slots_data_start_time[i],'endTime':@slots_data_end_time[i]}
  # end
  #   # if @service.nil?
  #   #   flash[:notice] = "Invalid Service"
  #   #   redirect_to public_page_path(@user.fname)
  #   # end
  #   filtered_slots = @slots.select { |slot| slot[:startTime] == @appointment.startdatetime }
    # start_time=DateTime.iso8601(@appointment.startdatetime)
    # start_date=Date.parse(@appointment.start_date)
    # start_time=Time.parse(@appointment.start_time)
    # puts start_date,start_time
    # Combine the date and time strings
combined_datetime = "#{@appointment.start_date} #{@appointment.start_time}"

# Parse the combined datetime string into a DateTime object
timestamp = DateTime.parse(combined_datetime)

puts timestamp
    # @appointment.startdatetime = new DataTime(@appointment.
    # start_time=@appointment.startdatetime
    end_time=timestamp+@service.duration*60
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
    params.require(:appointments).permit(:fname, :lname, :email, :startdatetime, :start_date, :start_time)
  end
end
