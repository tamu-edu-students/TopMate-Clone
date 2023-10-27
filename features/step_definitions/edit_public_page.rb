# frozen_string_literal: true

Given('I am on the edit the public page') do
  @user = User.create(fname: 'John', lname: 'Doe', username: 'jdoe', email: 'test@example.com', password: 'password',
                      about: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum')
  visit login_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Login'
  visit edit_public_page_path
end

When('I update my {string} to {string}') do |string, string2|
  expect(page).to have_current_path(edit_public_page_path)
  fill_in string, with: string2
end

And('I submit the update form by clicking on {string}') do |button_text|
  click_button(button_text)
end

Then('I should see information {string} on the public page') do |string|
  visit public_page_path('jdoe')
  expect(page).to have_content(string)
end
