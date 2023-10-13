Given('I am on the hours page') do
  @user = User.create(fname: "John", lname: "Doe", email: "test@example.com", password: "password")
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
  @user = User.create(fname: "John", lname: "Doe", email: "test@example.com", password: "password")
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
