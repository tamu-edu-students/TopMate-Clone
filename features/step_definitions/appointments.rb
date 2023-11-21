# frozen_string_literal: true

include AppointmentsHelper
Given('I am on public page of {string} for booking the appointment') do |_string|
  @user = User.create(email: 'testuser@gmail.com', password: 'Hello@#1999', fname: 'Jack', lname: 'Hill',
                      username: 'jackhill', about: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum')
  @user.save!
  @service = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem', price: 10, short_description: 'Lorem Ipsum',
                             duration: 60, is_published: true)
  @hour1 = Hour.create(user_id: @user.user_id, day: 0, start_time: '11:15:00', end_time: '15:15:00')
  @hour2 = Hour.create(user_id: @user.user_id, day: 1, start_time: '11:15:00', end_time: '15:15:00')
  @hour2 = Hour.create(user_id: @user.user_id, day: 1, start_time: '11:15:00', end_time: '15:15:00')
  @hour3 = Hour.create(user_id: @user.user_id, day: 2, start_time: '11:15:00', end_time: '15:15:00')
  @hour4 = Hour.create(user_id: @user.user_id, day: 3, start_time: '11:15:00', end_time: '15:15:00')
  @hour5 = Hour.create(user_id: @user.user_id, day: 4, start_time: '11:15:00', end_time: '15:15:00')
  @hour6 = Hour.create(user_id: @user.user_id, day: 5, start_time: '11:15:00', end_time: '15:15:00')
  @hour7 = Hour.create(user_id: @user.user_id, day: 6, start_time: '11:15:00', end_time: '15:15:00')
  visit public_page_path(@user.username)
end

When('I click on {string} to open service page') do |string|
  expect(page).to have_current_path(public_page_path(@user.username))

  click_link(string.gsub(' ', '_'))
end

Then('I clck on {string} to go the appointment page') do |string|
  click_link string
end

Then('I should be on the {string} booking appointment page of {string}') do |string, string2|
  expect(page).to have_content(string)
  expect(page).to have_content(string2)
end

Then('I fill in customer {string} with {string}') do |string, string2|
  fill_in string, with: string2
end

Then('I fill in customer {string} with first available start date') do |string|
  start_date = Date.today + @hour3.day
  select start_date.to_s, from: string
end

Then('I click the {string} button to create appointment') do |string|
  click_button string
end


Then('I should see a success message {string}') do |string|
  expect(page).to have_content(string)
end

Given('I have a registered user with email {string} and password {string} and first_name {string} and last_name {string} and username {string}') do |string, string2, string3, string4, string5|
  @user = User.create(email: string, password: string2, fname: string3, lname: string4,
                      username: string5, about: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum')

  @user.save!
  @service = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem', price: 10, short_description: 'Lorem Ipsum',
                             duration: 60, is_published: true)
end

When('I go to appointment page for one service of {string} to book appointment') do |string|
  visit appointments_page_index_path(string, @service.id)
  page.html
end

Then('I should redirected back to public page') do
  expect(page).to have_current_path(public_page_path(@user.username))
end

Then('I should see a error message {string}') do |string|
  expect(page).to have_content(string)
end

Given('I have created a appointment and now i want to update the data') do
  @user = User.create(email: 'testuser@gmail.com', password: 'Hello@#1999', fname: 'Jack', lname: 'Hill',
                      username: 'jackhill', about: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum')
  @user.save!
  @service = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem', price: 10, short_description: 'Lorem Ipsum',
                             duration: 60, is_published: true)
  @hour1 = Hour.create(user_id: @user.user_id, day: 0, start_time: '12:15:00', end_time: '15:15:00')
  @hour2 = Hour.create(user_id: @user.user_id, day: 1, start_time: '12:15:00', end_time: '15:15:00')
  @hour3 = Hour.create(user_id: @user.user_id, day: 2, start_time: '12:15:00', end_time: '15:15:00')
  @hour4 = Hour.create(user_id: @user.user_id, day: 3, start_time: '12:15:00', end_time: '15:15:00')
  @hour5 = Hour.create(user_id: @user.user_id, day: 4, start_time: '12:15:00', end_time: '15:15:00')
  @hour6 = Hour.create(user_id: @user.user_id, day: 5, start_time: '12:15:00', end_time: '15:15:00')
  @hour7 = Hour.create(user_id: @user.user_id, day: 6, start_time: '12:15:00', end_time: '15:15:00')

  @appointment = Appointment.create(
    service_id: @service.id,
    user_id: User.find_by(email: 'testuser@gmail.com').id,
    fname: 'John',
    lname: 'Wick',
    email: 'johnwick@gmail.com',
    startdatetime: DateTime.parse('2023-10-22T11:15:00'),
    enddatetime: DateTime.parse('2023-10-22T12:15:00'),
    amount_paid: 15.to_f,
    status: 'Booked',
    created_at: DateTime.parse('2023-10-24T14:30:00'),
    updated_at: DateTime.parse('2023-10-24T14:30:00')
  )
  @appointment.save!
end

When('I visit the edit appointment page') do
  visit edit_appointment_url(@appointment.id)
end

Then('I change my {string} with available time on {int} day from today') do |string, int|
  start_date = Date.today + int
  api_data= user_availability_for_day(@user, start_date)[0]
  slot = start_date.to_time + Time.parse(api_data['start_time']).seconds_since_midnight.seconds
  slot =DateTime.parse(slot.to_s)
  select slot.to_s, from: string
end

Then('The appointment should be updated with available time on {int} day from today in database') do |int|
    start_date = Date.today + int
    api_data= user_availability_for_day(@user, start_date)[0]
    slot = start_date.to_time + Time.parse(api_data['start_time']).seconds_since_midnight.seconds
    slot =DateTime.parse(slot.to_s)
    @app=Appointment.find_by(id:@appointment.id)
    date_in_timezone1 = Time.zone.parse(slot.to_s)
    date_in_timezone2 = Time.zone.parse(@app.startdatetime.to_s)
    date_in_utc1 = date_in_timezone1.utc
    date_in_utc2 = date_in_timezone2.utc
    expect(date_in_utc1).to eq(date_in_utc2)
  end


Then('I click the {string} button to update appointment data') do |string|
  click_button string
end
