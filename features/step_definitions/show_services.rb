Given("I am on the user's public page") do
  user = User.create(fname: 'John', lname: 'Doe', username: 'johndoe', email: 'test@example.com', password: 'password')
  user.save!
  service = Service.create(name: 'Service 1', short_description: 'sessions of 39 hr', price: 770, duration: 770,
    user_id: user.id, is_published: true)
  service.save!

  visit public_page_path(user.username)
end

When('I click on {string} link') do |string|
  click_link string
end