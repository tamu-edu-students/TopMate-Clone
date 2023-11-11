# frozen_string_literal: true

Given('I am on the hours page') do
  @user = User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password', username: 'jdoe')
  visit login_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Login'
  visit(hours_path)
end

When('I click on {string}') do |string|
  click_button string
end

Given('I am on the add hours page') do
  @user = User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password', username: 'jdoe')
  visit login_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Login'
  visit(new_hour_path)
end

Then('I should be on the hours page') do
  visit(hours_path)
end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end

Given('I fill in time select {string} with {string}') do |string, string2|
  base_dom_id = get_base_dom_id_from_label_tag(string)
  time = Time.zone.parse(string2)

  # Set the hour string
  hour = if time.hour.zero?
           '12 AM'
         elsif time.hour < 12
           "#{time.hour} AM"
         elsif time.hour == 12
           '12 PM'
         else
           "#{time.hour - 12} PM"
         end

  find(:xpath, ".//select[@id='#{base_dom_id}_4i']").select(hour)
  find(:xpath, ".//select[@id='#{base_dom_id}_5i']").select(time.min.to_s.rjust(2, '0'))
end
