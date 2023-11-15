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
        appointments:{
    fname: 'John',
    lname: 'Smith',
    email: 'js@gmail.com',
    start_date: '2023-10-22',
    start_time: '14:30:00',
    amount_paid: @service.price.to_f,
    status: 'booked'
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
end
