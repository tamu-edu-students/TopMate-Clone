# frozen_string_literal: true

Given('The user exists') do
  @user = User.create(fname: 'John', lname: 'Doe', username: 'jdoe', email: 'test@example.com', password: 'password')
  @service1 = Service.create(user_id: @user.user_id, name: 'Service 1', description: 'Description 1', price: 10,
                             duration: 60, is_published: true)
  @service2 = Service.create(user_id: @user.user_id, name: 'Service 2', description: 'Description 2', price: 15,
                             duration: 90, is_published: true)
end

When('I navigate to the public page') do
  visit public_page_path('jdoe')
end

Then('I should see the {string} page') do |string|
  if string == 'user not found'
    expect(page).to have_content('User jdoe does not have a public page set up.')
  else
    expect(page).to have_content(@user.lname)
  end
end

Given('The user does not exist') do
  User.destroy_all
end

Then('I should see the users services') do
  expect(page).to have_content(@service1.name)
end
