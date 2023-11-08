# frozen_string_literal: true

# Step definitions for Scenario 1: Viewing user's services from the dashboard

Given('I have multiple services listed under me') do
  @user = User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password')
  @service1 = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Description 1', price: 10,
                             duration: 60, is_published: true)
  @service2 = Service.create(user_id: @user.user_id, name: 'Service 2', description: 'Description 2', price: 15,
                             duration: 90, is_published: true)
  # Create more services as needed
end

When('I visit the dashboard page') do
  @user = User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password')
  visit login_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Login'
end

And('I click on the {string} button') do |button_text|
  click_link button_text
end

Then('I should see a list of all my services') do
  @user.services.each do |service|
    expect(page).to have_content(service.name)
    expect(page).to have_content(service.description)
    expect(page).to have_content(service.price)
    # Add more assertions as needed to verify other service details
  end
end

And('each service should display its details') do
  @user.services.each do |service|
    within(".service-#{service.id}") do
      expect(page).to have_content(service.name)
      expect(page).to have_content(service.description)
      expect(page).to have_content(service.price)
      expect(page).to have_content(service.duration)
      # Add more assertions as needed to verify other service details
    end
  end
end

# Step definitions for Scenario 2: Adding a new service

Given('I am on the services page') do
  @user = User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password')
  visit login_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Login'

  visit servicesindex_path
end

When('I click {string}') do |button_text|
  click_link button_text
end

And('I fill in the required service details') do
  fill_in 'Name', with: 'My Service'
  fill_in 'service_short_description', with: 'Service short description'
  fill_in 'Price', with: 10.99
  fill_in 'Duration', with: 60
end

And('I submit the form by clicking on {string}') do |button_text|
  click_button(button_text)
end

Then('the new service should be added to my services') do
  @user.reload
  expect(@user.services).to include(Service.last)
end

And('I should see a success message confirming the addition') do
  expect(page).to have_content('Service was successfully created.')
end
