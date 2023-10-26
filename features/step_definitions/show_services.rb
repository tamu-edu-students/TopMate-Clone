Given("I am on the user's public page") do
  @user = User.create(fname: 'John', lname: 'Doe', email: 'test@example.com', password: 'password')
  @user.save!

  visit login_path
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Login'
  
  service = Service.create(name: 'Service 1', description: 'sessions of 39 hr', price: 770, duration: 770,
    user_id: @user.id, is_published: true)
  service.save!

  visit public_page_path(@user.fname)
end

When('I click on {string} link') do |string|
  click_link string
end