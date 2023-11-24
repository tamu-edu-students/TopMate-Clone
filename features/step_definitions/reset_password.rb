# frozen_string_literal: true

Given('I am on {string} page') do |_page|
  user = User.create(email: 'userfortestingreset@gmail.com', password: 'jkjk1234$', fname: 'Test', lname: 'user',
                     id: '8268aa66-f830-4470-b7df-bff71fdc1cb9', username: 'testuser')
  user.save!
  session = ResetPasswordSession.create(user_id: '8268aa66-f830-4470-b7df-bff71fdc1cb9',
                                        session_token: '5abb5ecc-5e93-11ee-8c99-0242ac120002')
  session.save!
  visit '/reset/5abb5ecc-5e93-11ee-8c99-0242ac120002'
end


Given('a user with email {string}') do |string|
  @user = User.create(email: string, password: 'Hello@#1999', fname: 'Jack', lname: 'Hill',
                      username: 'jackhill', about: 'Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum')
  @user.save!
end

Given('I am on forgot password page') do
  visit submitemail_path
end

When('the user requests to reset their password for {string}') do |string|
  fill_in "email", with: string
end

When('I click on {string} to submit a reset password form') do |string|
  click_button string
end

Then('a success message should come {string}') do |string|
 expect(page).to have_content(string)
end
