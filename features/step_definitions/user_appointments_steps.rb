# frozen_string_literal: true

# Step definitions for Scenario 1: Viewing user's services from the dashboard

Given('I have multiple appointments listed under me') do
  @user = User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password', username:'jdoe')
  @service1 = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Description 2',short_description: 'Description 2', price: 15,
                             duration: 90, is_published: true)
  
  @user.save!
  @service1.save!
  @appointment1 = Appointment.create(
    service_id: @service1.id,
    user_id: User.find_by(fname: 'John').id,
    fname: 'rama',
    lname: 'krishna',
    email: 'rk@gmail.com',
    startdatetime: DateTime.parse('2023-10-22T14:30:00'),
    enddatetime: DateTime.parse('2023-10-22T15:00:00'),
    amount_paid: 15,
    status: 'Booked',
    created_at: DateTime.parse('2023-10-24T14:30:00'),
    updated_at: DateTime.parse('2023-10-24T14:30:00')
  )
  @appointment2 = Appointment.create(
    service_id: @service1.id,
    user_id: User.find_by(fname: 'John').id,
    fname: 'zula',
    lname: 'kakbar',
    email: 'zk@gmail.com',
    startdatetime: DateTime.parse('2023-10-23T14:30:00'),
    enddatetime: DateTime.parse('2023-10-23T15:00:00'),
    amount_paid: 15,
    status: 'Booked',
    created_at: DateTime.parse('2023-10-24T14:30:00'),
    updated_at: DateTime.parse('2023-10-24T14:30:00')
  )
  @appointment1.save
  @appointment2.save
  # Create more appointments as needed
end


And('I click on {string} button') do |button_text|
  click_link button_text
end

Then('I should see a list of all my appointments') do
  @user.appointments.each do |appointment|
    expect(page).to have_content(appointment.fname)
    expect(page).to have_content(appointment.lname)
    expect(page).to have_content(appointment.email)
    expect(page).to have_content(appointment.amount_paid)
    expect(page).to have_content(appointment.status)
    # Add more assertions as needed to verify other service details
  end
end

And('each appointment should display its details') do
  @user.appointments.each do |appointment|
    within("appointment-#{appointment.id}") do
      expect(page).to have_content(appointment.fname)
      expect(page).to have_content(appointment.lname)
      expect(page).to have_content(appointment.email)
      expect(page).to have_content(appointment.amount_paid)
      expect(page).to have_content(appointment.status)
      # Add more assertions as needed to verify other appointment details
    end
  end
end

