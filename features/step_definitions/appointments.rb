# frozen_string_literal: true

Given('I am on public page of {string} for booking the appointment') do |string|
  @user = User.create(email: "testuser@gmail.com", password: "Hello@#1999", fname: "Jack", lname: "Hill", username: "Jack", about: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum")
  @user.save!
  @service1 = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Description 1', price: 10,
                             duration: 60, is_published: true)
  @service2 = Service.create(user_id: @user.user_id, name: 'Service 2', description: 'Description 2', price: 15,
                             duration: 90, is_published: true)
  visit public_page_path("Jack")
end

When('I click on {string} for {string}') do |string, string2|
  expect(page).to have_current_path(public_page_path("Jack"))
  puts page.current_url



  # find("#"+string2.gsub(' ', '_')).click_button
  click_link(string2.gsub(' ', '_'))
  # click_button
end

Then('I should be on the  {string} booking appointment page of {string}') do |string, string2|
  expect(page).to have_content(string)
  expect(page).to have_content(string2)
end

Then('I fill in customer {string} with {string}') do |string, string2|
  fill_in string, with: string2
  # fill_in string.gsub(' ', '_'), with: string2
end

Then('I fill in customer {string} with first available start date') do |string|
  puts find_by_id(string,  visible: true).value
  # find_by_id(string,  visible: true).value="2023-10-27"

  select "2023-10-27", from: string
  puts find_by_id(string,  visible: true).value
end

Then('I fill in customer {string} with first available start time') do |string|
  # page.execute_script("return fetch_slot_times();")

  # sleep(10)
  # wait_until { page.evaluate_script('window.apiCallCompleted') }
  # timeout = 10 # Set the timeout duration in seconds
  # start_time = Time.now

  # until Time.now - start_time >= timeout
  #   # Check if the API call has completed (replace with your condition)
  #   break if page.evaluate_script('window.apiCallCompleted')

  #   sleep(0.5) # Wait for 0.5 seconds before checking again
  # end

  puts page.html
  puts "hello", find_by_id(string,  visible: true).inspect
  select "12:00:00 GMT-0500 (Central Daylight Time)", from: string, visible: true
end


Then('I should redirected back to public page of {string}') do |string|
  expect(page).to have_current_path(public_page_path("Jack"))
end

Then('I should see a success message {string}') do |string|
  expect(page).to have_content(string)
end
