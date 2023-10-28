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
  # sleep(5)
  puts find_by_id(string,  visible: true).value
  # find_by_id(string,  visible: true).value="2023-10-27"
  puts page.html
  # select "2023-10-24T19:30:00+00:00", from: 'appointments_startdatetime'
  # puts find_by_id('appointments_startdatetime',  visible: true).value
end

Then('I click the {string} button to create appointment') do |string|
  click_button string
end


Then('I should redirected back to public page of {string}') do |string|
  expect(page).to have_current_path(public_page_path("Jack"))
end

Then('I should see a success message {string}') do |string|
  expect(page).to have_content(string)
end
