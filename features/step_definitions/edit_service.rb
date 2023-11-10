# frozen_string_literal: true

Given('I am on {string} page for an existing service') do |_p|
  @user = User.create(fname: 'Geetesh', lname: 'Doe', email: 'editservices@example.com', password: 'password12@')
  @user.save!

  visit login_path
  fill_in 'Email', with: 'editservices@example.com'
  fill_in 'Password', with: 'password12@'
  click_button 'Login'

  service = Service.create(name: 'Mock Interview', short_description: 'sessions of 39 hr', price: 770, duration: 770,
                           user_id: @user.id)
  service.save!

  visit "/editService/#{service.id}"
end

Given('I am on {string} page for an invalid service') do |_p|
  @user = User.create(fname: 'Geetesh', lname: 'Doe', email: 'editservices@example.com', password: 'password12@')
  @user.save!

  visit login_path
  fill_in 'Email', with: 'editservices@example.com'
  fill_in 'Password', with: 'password12@'
  click_button 'Login'

  visit '/editService/1234'
end
