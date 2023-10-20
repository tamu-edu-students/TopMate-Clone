# frozen_string_literal: true

# Step definitions for Scenario: delete an existing service

Given('I am on the services index page') do
  @user = User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password')
  @user.save!

  visit login_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Login'
  
  service = Service.create(name: 'service 123', description: 'sessions of 39 hr', price: 770, duration: 770,
    user_id: @user.id)
  service.save!

  visit servicesindex_path
end

When('I click {string} button for {string}') do |button_text, service_name|
    # Find the service based on its name
    service = Service.find_by(name: service_name)
    if service
      delete_button = find("#delete-service-#{service.id}")
      delete_button.click
    else
      raise "Service not found: #{service_name}"
    end
end

Then("I should see a success message confirming the deletion") do
  expect(page).to have_content("Service deleted successfully.")
end

And('{string} should\'nt be there in the services index page') do |service_name|
  expect(page).not_to have_content(service_name)
end
