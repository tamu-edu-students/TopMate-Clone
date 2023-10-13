# frozen_string_literal: true

Given('I have a registered user with email {string} and password {string} and first_name {string} and last_name {string}') do |email, password, first_name, last_name|
  user = User.create(email:, password:, fname: first_name, lname: last_name)
  user.save!
end

When('I visit the login page') do
  visit login_path
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I click the {string} button') do |button|
  click_button button
end

Then('I should be on the dashboard page') do
  expect(page).to have_current_path(dashboard_path)
end

Then('I should see {string}') do |content|
  expect(page).to have_content(content)
end

Then('I should still be on the login page') do
  expect(page).to have_current_path(login_path)
end
