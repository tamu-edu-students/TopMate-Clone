# frozen_string_literal: true

# spec/controllers/dashboard_controller_spec.rb

require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  describe 'POST #create_submit' do
    before do
      @user = User.create(email: 'testuser@gmail.com', password: 'Hello@#1999', fname: 'Jack', lname: 'Hill',
                          username: 'jackhill', about: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum')
      @user.save!
      @service = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem', price: 10, short_description: 'Lorem Ipsum',
                             duration: 60, is_published: true)
      @hour1 = Hour.create(user_id: @user.user_id, day: 0, start_time: '11:15:00', end_time: '15:15:00')
      @hour2 = Hour.create(user_id: @user.user_id, day: 1, start_time: '11:15:00', end_time: '15:15:00')
      @hour3 = Hour.create(user_id: @user.user_id, day: 2, start_time: '11:15:00', end_time: '15:15:00')
      @hour4 = Hour.create(user_id: @user.user_id, day: 3, start_time: '11:15:00', end_time: '15:15:00')
      @hour5 = Hour.create(user_id: @user.user_id, day: 4, start_time: '11:15:00', end_time: '15:15:00')
      @hour6 = Hour.create(user_id: @user.user_id, day: 5, start_time: '11:15:00', end_time: '15:15:00')
      @hour7 = Hour.create(user_id: @user.user_id, day: 6, start_time: '11:15:00', end_time: '15:15:00')
    end
    context 'with valid parameters' do
      it 'creates a new appointment' do
        post :create_submit,params: { username: @user.username,service_id: @service.id ,
        appointment:{
    fname: 'John',
    lname: 'Smith',
    email: 'js@gmail.com',
    start_date: '2023-10-22',
    start_time: '14:30:00',
    amount_paid: @service.price.to_f,
    status:  Appointment.status_types['booked']
        }
      }
        expect(response).to redirect_to(public_page_path(@user.username))
        expect(flash[:success]).to eq('Appointment Created successfully')
        expect(assigns(:save)).to be true
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new appointment and redirects with error message' do
        post :create_submit, params: {
          username: @user.username,
          service_id: @service.id,
          appointment: {
            fname: '',
            lname: '',
            email: '',
            start_date: '',
            start_time: '',
            amount_paid: @service.price.to_f,
            status: Appointment.status_types['booked']
          }
        }

        expect(response).to redirect_to(appointments_page_index_path(@user.username, @service.id))
        expect(flash[:error]).to include("Please enter your First Name, Last Name, Email, Appointment Date, Consultation Start Time")
        expect(assigns(:save)).to be_nil
      end
    end

    context 'with valid parameters' do
      it 'creates a new appointment' do
        post :create_submit, params: {
          username: @user.username,
          service_id: @service.id,
          appointment: {
            fname: 'John',
            lname: 'Smith',
            email: 'js@gmail.com',
            start_date: '2023-10-22',
            start_time: '14:30:00',
            amount_paid: @service.price.to_f,
            status: Appointment.status_types['booked']
          }
        }

        expect(response).to redirect_to(public_page_path(@user.username))
        expect(flash[:success]).to eq('Appointment Created successfully')
        expect(assigns(:save)).to be true
      end
    end
  end

  describe 'GET #fetch_slot_times_api' do
    before do
      @user = User.create(email: 'testuser@gmail.com', password: 'Hello@#1999', fname: 'Jack', lname: 'Hill',
                          username: 'jackhill', about: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum')
      @user.save!
      @hour1 = Hour.create(user_id: @user.user_id, day: 0, start_time: '11:15:00', end_time: '15:15:00')
      @hour1 = Hour.create(user_id: @user.user_id, day: 0, start_time: '21:15:00', end_time: '23:15:00')
      @hour2 = Hour.create(user_id: @user.user_id, day: 1, start_time: '11:15:00', end_time: '15:15:00')
      @hour3 = Hour.create(user_id: @user.user_id, day: 2, start_time: '11:15:00', end_time: '15:15:00')
      @hour4 = Hour.create(user_id: @user.user_id, day: 3, start_time: '11:15:00', end_time: '15:15:00')
      @hour5 = Hour.create(user_id: @user.user_id, day: 4, start_time: '11:15:00', end_time: '15:15:00')
      @hour6 = Hour.create(user_id: @user.user_id, day: 5, start_time: '11:15:00', end_time: '15:15:00')
      @hour7 = Hour.create(user_id: @user.user_id, day: 6, start_time: '11:15:00', end_time: '15:15:00')
    end
    context 'when slots are available' do
      it 'returns a list of slots' do
        @current_date = Date.today
        get :fetch_slot_times_api, params: { username: @user.username, start_date: @current_date }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #index' do
    let(:user) { create(:user, username: 'testuser') }
    let(:service) { create(:service) }

    context 'when user exists' do
      before { get :index, params: { username: user.username, service_id: SecureRandom.uuid } }

      it 'assigns the username' do
        expect(assigns(:username)).to eq(user.username)
      end

      it 'assigns the user' do
        expect(assigns(:user)).to eq(user)
      end

      # it 'assigns nil to service_id' do
      #   expect(assigns(:service_id)).to be_nil
      # end

      it 'assigns nil to service' do
        expect(assigns(:service)).to be_nil
      end

      it 'redirects to public page if user is nil' do
        get :index, params: { username: 'nonexistentuser', service_id: service.id }
        expect(response).to redirect_to(public_page_path(user.username))
      end

      it 'redirects to public page if service is nil' do
        get :index, params: { username: user.username, service_id: 123 }
        expect(response).to redirect_to(public_page_path(user.username))
      end
    end

    context 'when service exists' do
      before { get :index, params: { username: user.username, service_id: service.id } }

      it 'assigns the username' do
        expect(assigns(:username)).to eq(user.username)
      end

      it 'assigns the user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'assigns the service_id' do
        expect(assigns(:service_id)).to eq(service.id)
      end

      it 'assigns the service' do
        expect(assigns(:service)).to eq(service)
      end

      it 'creates a new appointment' do
        expect(assigns(:appointment)).to be_a_new(Appointment)
      end

      it 'assigns the next seven days' do
        expect(assigns(:slots_data_start_date)).to eq([Date.today, Date.today + 1, Date.today + 2, Date.today + 3, Date.today + 4, Date.today + 5, Date.today + 6])
      end

      it 'assigns an empty array for slots_data_start_time' do
        expect(assigns(:slots_data_start_time)).to eq([])
      end
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:user, username: 'testuser') }
    let(:service) { create(:service) }
    let(:appointment) { create(:appointment, user_id: user.user_id, service_id: service.id ) }
    let(:api_data) { [{ 'start_date_time' => '2023-11-22T10:00:00Z', 'end_date_time' => '2023-11-22T11:00:00Z' }] }

    before do
      allow(controller).to receive(:get_next_seven_day_time_slots).and_return(api_data)
    end

    context 'when the appointment exists' do
      it 'assigns the appointment, user, service, and slots' do
        get :edit, params: { id: appointment.id }

        expect(assigns(:appointment)).to eq(appointment)
        expect(assigns(:user)).to eq(user)
        expect(assigns(:service)).to eq(service)
        expect(assigns(:slots)).to eq([{ startTime: DateTime.parse(api_data[0]['start_date_time']),
                                         endTime: DateTime.parse(api_data[0]['end_date_time']) }])
        expect(assigns(:slots_data_start_datetime)).to eq([DateTime.parse(api_data[0]['start_date_time'])])
        expect(assigns(:slots_data_end_datetime)).to eq([DateTime.parse(api_data[0]['end_date_time'])])
      end

      it 'renders the edit template' do
        get :edit, params: { id: appointment.id }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "PATCH #update" do
    let(:user) { create(:user, username: 'testuser') }
    let(:service) { create(:service) }
    let(:appointment) { create(:appointment, user_id: user.id, service_id: service.id) }

    context "with valid parameters" do
      let(:update_params) { { appointment: { startdatetime: DateTime.now } } }

      before do
        patch :update, params: { id: appointment.id, appointment: update_params }
        appointment.reload
      end

      it "assigns the appointment" do
        expect(assigns(:appointment)).to eq(appointment)
      end

      it "assigns the user" do
        expect(assigns(:user)).to eq(user)
      end

      it "assigns the service" do
        expect(assigns(:service)).to eq(service)
      end

      it "updates the appointment with new startdatetime" do
        date_in_timezone1 = Time.zone.parse(appointment.startdatetime.to_s)
        date_in_timezone2 = Time.zone.parse(update_params[:appointment][:startdatetime].to_s)
        date_in_utc1 = date_in_timezone1.utc
        date_in_utc2 = date_in_timezone2.utc
        expect(date_in_utc1).to eq(date_in_utc2)
      end

      it "updates the appointment enddatetime based on service duration" do
        expect(appointment.enddatetime).to eq(appointment.startdatetime + service.duration.minutes)
      end

      it "redirects to the public page with success message" do
        expect(response).to redirect_to(public_page_path(user.username))
        expect(flash[:success]).to eq('Appointment updated successfully!')
      end
    end

    context "with invalid parameters" do
      let(:update_params) { { fname: nil }  }

      before do
        patch :update, params: { id: appointment.id, appointment: update_params }
        appointment.reload
      end

      it "assigns the appointment" do
        expect(assigns(:appointment)).to eq(appointment)
      end

      it "assigns the user" do
        expect(assigns(:user)).to eq(user)
      end

      it "assigns the service" do
        expect(assigns(:service)).to eq(service)
      end

      it "does not update the appointment" do
        expect(appointment.fname).not_to eq(update_params[:fname])
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
  before do
    @user = User.create(email: 'testuser@gmail.com', password: 'Hello@#1999', fname: 'Jack', lname: 'Hill', username: 'jackhill')
    @user.save!
    @service = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Lorem Ipsum', price: 10, short_description: 'Lorem Ipsum', duration: 60, is_published: true)
    @appointment = Appointment.create(
      fname: 'John',
      lname: 'Smith',
      email: 'js@gmail.com',
      start_date: '2023-10-22',
      start_time: '14:30:00',
      amount_paid: @service.price.to_f,
      status: Appointment.status_types['booked'],
      user_id: @user.id,
      service_id: @service.id
    )
    @appointment.save!
  end

  it 'cancels the appointment and redirects with success message' do
    delete :destroy, params: { id: @appointment.id }

    expect(response).to redirect_to(public_page_path(@user.username))
    expect(flash[:success]).to eq('Appointment cancelled successfully!')

    # Reload the appointment from the database to ensure it was updated
    reloaded_appointment = Appointment.find(@appointment.id)
    expect(reloaded_appointment.status).to eq(Appointment.status_types['cancelled'])
  end
end
end
